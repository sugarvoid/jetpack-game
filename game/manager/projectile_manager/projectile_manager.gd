class_name ProjectileManager
extends Node2D

const p_Projectile: PackedScene = preload("res://game/projectile/projectile.tscn")


func add_bullet_to_screen(weapon: Weapon) -> void:
	var projectile = p_Projectile.instantiate()
	# projectile.damage_amount = actor.attack
	projectile.global_transform = weapon.muzzle.global_transform
	projectile.speed = weapon.bullet_speed
	self.add_child(projectile)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
