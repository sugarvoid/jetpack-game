class_name Level
extends Node2D

signal on_done
signal all_dead
signal wave_complete

var tiltemap: TileMap

@onready var player_spawn_point: Marker2D = get_node("PlayerSpawn")
@onready var enemy_container: Node2D = get_node("EnemyContainer")


# Enemies that will appear in this level
const level_enemies: Array[Array] = [
	[
		"res://game/actor/enemy/enemy.tscn",
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
	self.spawn_mob(level_enemies[0][0], $EnemySpawnPoints/G0.global_position )

func get_mob_count() -> int:
	return self.enemy_container.get_child_count()

func get_player_start_pos() -> Vector2:
	return self.player_spawn_point.global_position

func _check_for_completion() -> void:
	if self.enemy_container.get_child_count() == 0:
		print('all dead signal')
		self.emit_signal("all_dead")


func spawn_mob(e_type: String, spwan_loc: Vector2) -> void:
	var new_e: Enemy = load(e_type).instantiate()
	new_e.has_died.connect(self.remove_mob)
	new_e.global_position = spwan_loc
	self.enemy_container.add_child(new_e)

func remove_mob(e: Enemy) -> void:
	self.enemy_container.remove_child(e)
	_check_for_completion()
