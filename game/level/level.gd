class_name Level
extends Node2D

signal on_done
signal all_dead

var tiltemap: TileMap

@onready var player_spawn_point: Marker2D = get_node("PlayerSpawn")
@onready var enemy_container: Node2D = get_node("EnemyContainer")


# Enemies that will appear in this level
const level_enemies: Array[Array] = [
	[
		1,
		2,
		3
	],
	[
		1,
		4,
		5,
	]
]

var wave: int = 0 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print('level is ready!!!')

func get_mob_count() -> int:
	return self.enemy_container.get_child_count()

func get_player_start_pos() -> Vector2:
	return self.player_spawn_point.global_position

func _check_for_completion() -> void:
	if self.enemy_container.get_child_count() == 0:
		self.emit_signal("all_dead")
