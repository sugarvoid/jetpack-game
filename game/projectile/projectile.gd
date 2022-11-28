class_name Projectile
extends Area2D



@onready var sprite: Sprite2D = get_node("Sprite")

var projectile_ID: String
var speed: float
var life: float

func get_class() -> String:
	return "Projectile"

func set_projectile_properties(weapon: Weapon) -> void:
	self.speed = weapon.bullet_speed
	self.life = weapon.bullet_life
	self.sprite.frame = weapon.bullet_sprite_frame
	self.projectile_ID = weapon.bullet_ID

func _physics_process(delta):
	global_position += Vector2(cos(rotation), sin(rotation)) * speed * delta

func _ready() -> void:
	$LifeTimer.start(self.life)

func _on_LifeTimer_timeout() -> void:
	queue_free()

func made_contact(thing: Node2D) -> void:
	print(thing)
	thing.take_damage(2)
	self.queue_free()
