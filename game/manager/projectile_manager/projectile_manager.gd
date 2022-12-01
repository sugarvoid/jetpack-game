class_name ProjectileManager
extends Node2D

const p_Projectile: PackedScene = preload("res://game/projectile/projectile.tscn")


func add_player_bullet_to_screen(weapon: Weapon) -> void:
	var projectile = p_Projectile.instantiate()
	# projectile.damage_amount = actor.attack
	projectile.global_transform = weapon.muzzle.global_transform
	projectile.speed = weapon.bullet_speed
	self.add_child(projectile)

