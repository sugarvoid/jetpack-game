class_name Player
extends Actor

signal request_bullet(pos: Marker2D)
signal landed

@onready var weapon: Weapon = get_node("Hand/Weapon")

var ground_damge: int = 1
var air_damage: int = 5
var is_facing_right: bool = true
var is_reloading: bool = false
var jet_pack_heat: float = 0
var jet_pack_max_heat: float = 50
var is_grounded: bool = false


func _ready() -> void:
	self.jump_velocity = -40
	self.speed = 100
	self.weapon.can_shoot_bullet.connect(self._fire_weapon)


func _fire_weapon(weapon: Weapon) -> void:
	self.emit_signal("request_bullet", weapon)


func _input(event: InputEvent) -> void:
	if event.is_action_released("reload"):
		_reload()


func _update_facing_dir(target: Vector2):
	if target.x < 0:
		if is_facing_right:
			scale.x = -1
			is_facing_right = false
	else: 
		if not is_facing_right:
			scale.x = 1
			is_facing_right = true


func _physics_process(delta: float) -> void:
	$Label.text = str(self.get_jetpack_heat())
	var mouse_location: Vector2 = get_local_mouse_position()
	self._update_facing_dir(mouse_location)
	
	if !self.is_reloading:
		$Hand/Weapon.look_at(get_global_mouse_position())
	# Add the gravity.
	if not is_on_floor():
		$Flame.visible = false
		is_grounded = false
		velocity.y = min(velocity.y + 3, gravity) 
		#velocity.y += gravity * delta
	else:
		is_grounded = true
		self.emit_signal("landed")

	# Handle Jump.
	if Input.is_action_pressed("jump"): # and is_on_floor():
		$Flame.visible = true
		velocity.y = min(velocity.y - 2, jump_velocity)
		self.jet_pack_heat = clamp(jet_pack_heat + 0.2, 0, self.jet_pack_max_heat)
	else:
		# not pressing gas
		self.jet_pack_heat = clamp(jet_pack_heat - 0.25, 0, self.jet_pack_max_heat)
	if Input.is_action_just_pressed("shoot"):
		if !self.is_reloading:
			self.weapon.set_damage_amount(self._get_damage_amount())
			$Hand/Weapon.fire_bullet()
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

func _reload() -> void:
	self.is_reloading = true
	$AnimationPlayer.play("reload")
	self.weapon.reload()
	

func _get_damage_amount() -> int:
	if self.is_grounded:
		return self.ground_damge
	else:
		return self.air_damage


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "reload":
		self.is_reloading = false

func get_jetpack_heat() -> float:
	return snapped(self.jet_pack_heat, 0.1)
