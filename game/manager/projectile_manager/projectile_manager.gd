class_name ProjectileManager
extends Node2D

const p_Projectile: PackedScene = preload("res://game/projectile/projectile.tscn")
var rng: RandomNumberGenerator

func _ready() -> void:
	rng = RandomNumberGenerator.new()

func add_player_bullet_to_screen(weapon: Weapon) -> void:
	rng.randomize()
	var projectile = p_Projectile.instantiate()
	projectile.damage_given = weapon.base_damage
	projectile.global_transform = weapon.muzzle.global_transform
	var offset = randf_range(weapon.spread, -weapon.spread)
	projectile.rotation += offset 
	projectile.speed = weapon.bullet_speed
	self.add_child(projectile)

