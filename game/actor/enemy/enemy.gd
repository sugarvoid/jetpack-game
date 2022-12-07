class_name Enemy
extends Actor



func _ready() -> void:
	speed = 100.0
	jump_velocity = -40.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y = min(velocity.y + 6, gravity) 
		velocity.y += gravity * delta
	move_and_slide()
