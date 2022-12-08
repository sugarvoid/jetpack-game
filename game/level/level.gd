class_name Level
extends Node2D

var tiltemap: TileMap

@onready var player_spawn_point: Marker2D = get_node("PlayerSpawn")


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

var phase: int = 0 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
