class_name Enemy
extends Actor

var direction = -1

func _ready() -> void:
	speed = 10
	jump_velocity = -40.0

func _physics_process(delta: float) -> void:
	if self._check_if_on_wall():
		_turn_around()
	_walk()
	# Add the gravity.
	if not is_on_floor():
		velocity.y = min(velocity.y + 6, gravity) 
		velocity.y += gravity * delta
	move_and_slide()

func _check_if_on_wall() -> bool:
	return self.is_on_wall()

func _turn_around() -> void:
	self.direction *= -1

func _walk() -> void:
	
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
