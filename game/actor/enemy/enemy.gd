class_name Enemy
extends Actor

signal  has_died(e: Enemy)

var direction = -1
var max_health: int = 15
var health: int

func _ready() -> void:
	health = 15
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

func take_damage(n: int) -> void:
	#print('taken: ', n, ' damage')
	print(health)
	self.health = clamp(health - n, 0, max_health)
	if self.health == 0:
		print(self.health)
		self.emit_signal("has_died", self)

func _walk() -> void:
	
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
