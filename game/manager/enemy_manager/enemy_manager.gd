class_name EnemyManager
extends Node2D

@onready var enemy_container: Node2D = get_node("EnemyContainer")
@onready var spoint: Marker2D = get_node("SpawnPonits/0,4")

const p_Enemy: PackedScene = preload("res://game/actor/enemy/enemy.tscn")


var _current_mobs: int

func _ready() -> void:
	self.spawn_mob(self.spoint.global_position)


func get_mob_count() -> int:
	return self.enemy_container.get_child_count()
	

func spawn_mob(spwan_loc: Vector2) -> void:
	var new_e: Enemy = p_Enemy.instantiate()
	new_e.has_died.connect(self.remove_mob)
	new_e.global_position = spwan_loc
	self.enemy_container.add_child(new_e)

func remove_mob(e: Enemy) -> void:
	self.enemy_container.remove_child(e)
