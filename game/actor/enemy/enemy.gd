class_name Enemy
extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -40.0

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y = min(velocity.y + 6, gravity) 
		velocity.y += gravity * delta
	move_and_slide()
