class_name EnemySpawner
extends Node2D


const p_Enemy: PackedScene = preload("res://game/actor/enemy/enemy.tscn")

var _current_mobs: int

func _ready() -> void:
	pass


func spawn_mob(e_type: PackedScene, spwan_loc: Vector2) -> void:
	var new_e: Enemy = p_Enemy.instantiate()
	new_e.has_died.connect(self.remove_mob)
	new_e.global_position = spwan_loc
	self.enemy_container.add_child(new_e)

func remove_mob(e: Enemy) -> void:
	self.enemy_container.remove_child(e)
