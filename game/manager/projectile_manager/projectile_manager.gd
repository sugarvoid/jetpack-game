class_name ProjectileManager
extends Node2D

const p_Projectile: PackedScene = preload("res://game/projectile/projectile.tscn")
var rng: RandomNumberGenerator

func _ready() -> void:
	rng = RandomNumberGenerator.new()

func add_player_bullet_to_screen(weapon: Weapon) -> void:
	rng.randomize()
	var projectile = p_Projectile.instantiate()
	projectile.sprite_frame = weapon.bullet_sprite_frame
	projectile.damage_given = weapon.damage
	projectile.global_transform = weapon.muzzle.global_transform
	var offset = randf_range(weapon.spread, -weapon.spread)
	projectile.rotation += offset 
	projectile.speed = weapon.bullet_speed
	self.add_child(projectile)

