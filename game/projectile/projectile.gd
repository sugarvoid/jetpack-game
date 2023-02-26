class_name Projectile
extends Area2D

@onready var sprite: Sprite2D = get_node("Sprite")

var projectile_ID: String
var speed: float
var life: float
var damage_given: int
var sprite_frame: int

func get_class_name() -> String:
	return "Projectile"


func set_projectile_properties(weapon: Weapon) -> void:
	self.speed = weapon.bullet_speed
	self.life = weapon.bullet_life
	self.projectile_ID = weapon.bullet_ID


func _physics_process(delta):
	self.global_position += Vector2(cos(rotation), sin(rotation)) * speed * delta


func _ready() -> void:
	self.sprite.frame = self.sprite_frame
	$LifeTimer.start(self.life)
	self.body_entered.connect(self.made_contact)


func _on_LifeTimer_timeout() -> void:
	self.queue_free()


func made_contact(thing: Node2D) -> void:
	if thing.has_method("take_damage"):
		thing.take_damage(self.damage_given)
	else:
		self.queue_free()
