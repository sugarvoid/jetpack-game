class_name Player
extends CharacterBody2D

signal request_bullet(pos: Marker2D)

const SPEED = 100.0
const JUMP_VELOCITY = -40.0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_facing_right: bool = true
var is_reloading: bool = false
var jet_pack_heat: float = 0
var jet_pack_max_heat: int = 0


@onready var weapon: Weapon = get_node("Hand/Weapon")

func _ready() -> void:
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
	
	print(self.jet_pack_heat)
	var mouse_location: Vector2 = get_local_mouse_position()
	self._update_facing_dir(mouse_location)
	
	if !self.is_reloading:
		$Hand/Weapon.look_at(get_global_mouse_position())
	# Add the gravity.
	if not is_on_floor():
		velocity.y = min(velocity.y + 3, gravity) 
		#velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_pressed("jump"): # and is_on_floor():
		velocity.y = min(velocity.y - 2, JUMP_VELOCITY)
		self.jet_pack_heat += 0.2
	if Input.is_action_just_pressed("shoot"):
		if !self.is_reloading:
			$Hand/Weapon.fire_bullet()
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _reload() -> void:
	self.is_reloading = true
	$AnimationPlayer.play("reload")
	self.weapon.reload()
	

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "reload":
		self.is_reloading = false
