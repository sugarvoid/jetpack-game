class_name Player
extends Actor

signal request_bullet(pos: Marker2D)
signal landed

@onready var weapon: Weapon = get_node("Hand/Weapon")
@onready var spr_flame: AnimatedSprite2D = $Flame

var ground_damge: int = 1
var air_damage: int = 5
var is_facing_right: bool = true
var is_reloading: bool = false
var _jet_pack_heat: float = 0
var _jet_pack_max_heat: float = 30
var is_grounded: bool = false
var is_overheated: bool = false


func _ready() -> void:
	self.jump_velocity = -40
	self.speed = 100
	self.weapon.can_shoot_bullet.connect(self._fire_weapon)


func _fire_weapon(weapon: Weapon) -> void:
	self.emit_signal("request_bullet", weapon)


func _input(event: InputEvent) -> void:
	if event.is_action_released("reload"):
		_reload()
	if event.is_action_pressed("shoot"):
		if !self.is_reloading:
			self.weapon.set_damage_amount(self._get_damage_amount())
			$Hand/Weapon.fire_bullet()


func _update_facing_dir(target: Vector2):
	if target.x < 0:
		if self.is_facing_right:
			self.scale.x = -1
			self.is_facing_right = false
	else: 
		if not is_facing_right:
			self.scale.x = 1
			self.is_facing_right = true


func _process(delta: float) -> void:
	if self._jet_pack_heat == 30 && !self.is_overheated:
		print('over heat mode')
		self.is_overheated = true
	
	if self._jet_pack_heat == 0 && self.is_overheated:
		self.is_overheated = false
		print('over heat mode over')


func _physics_process(delta: float) -> void:
	self._aim()
	var mouse_location: Vector2 = get_local_mouse_position()
	self._update_facing_dir(mouse_location)
	
	# Add the gravity.
	if not is_on_floor():
		self.spr_flame.visible = false
		self.is_grounded = false
		self.velocity.y = min(velocity.y + 4, gravity) 

	else:
		self.is_grounded = true
		self.emit_signal("landed")

	# Handle Jump.
	if Input.is_action_pressed("jump") and !self.is_overheated:
		self.spr_flame.visible = true
		self.velocity.y = min(velocity.y - 2, jump_velocity)
		self._jet_pack_heat = clamp(_jet_pack_heat + 0.2, 0, self._jet_pack_max_heat)
	else:
		# not pressing gas
		self._jet_pack_heat = clamp(_jet_pack_heat - 0.25, 0, self._jet_pack_max_heat)
	
	self._handle_movement()

func _aim() -> void:
	if !self.is_reloading:
		$Hand/Weapon.look_at(get_global_mouse_position())


func _handle_movement() -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		self.velocity.x = direction * speed
	else:
		self.velocity.x = move_toward(velocity.x, 0, speed)
	move_and_slide()

func _reload() -> void:
	self.is_reloading = true
	$AnimationPlayer.play("reload")
	self.weapon.reload()
	

func _get_damage_amount() -> int:
	if self.is_grounded:
		self.weapon.bullet_sprite_frame = 5
		return self.ground_damge
	else:
		self.weapon.bullet_sprite_frame = 0
		return self.air_damage


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "reload":
		self.is_reloading = false


func get_jetpack_heat() -> float:
	return snapped(self._jet_pack_heat, 0.1)


func get_jetpack_max_heat() -> float:
	return self._jet_pack_max_heat
