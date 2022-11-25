class_name Player
extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -40.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_facing_right: bool = true

func _update_facing_dir(target: Vector2):

	if target.x < 0:
		if is_facing_right:
			scale.x = -1
			is_facing_right = false
	else: 
		if not is_facing_right:
			scale.x = 1
			is_facing_right = true



#	#Horizontal flip
#	if target.x > self.global_position.x && is_facing_right == false:
#		self.scale.x = 1
#		self.is_facing_right = true
#
#	if target.x < self.global_position.x && is_facing_right == true:
#		self.scale.x = -1
#		self.is_facing_right = false


func _physics_process(delta: float) -> void:
	
	var mouse_location: Vector2 = get_local_mouse_position()
	self._update_facing_dir(mouse_location)
	
	$Marker2D/agun.look_at(get_global_mouse_position())
	# Add the gravity.
	if not is_on_floor():
		velocity.y = min(velocity.y + 3, gravity) 
		#velocity.y += gravity * delta



	# Handle Jump.
	if Input.is_action_pressed("jump"): # and is_on_floor():
		velocity.y = min(velocity.y - 2, JUMP_VELOCITY)
	if Input.is_action_just_pressed("shoot"):
		print('bang')
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
