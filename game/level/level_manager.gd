class_name Level_Manager
extends Node2D

signal on_done
signal all_dead
signal wave_completed
signal level_completed

@onready var tmr_level_start: Timer = get_node("TmrLevelStart")
@onready var tmr_wave_delay: Timer = get_node("TmrWaveDelay")

@onready var enemy_container: Node2D = get_node("EnemyContainer")

const LEVEL_DATA: Array[Dictionary] = [
	{
		"level": 1,
		"tilemap_path": "res://game/level/tilemap/level_1.tscn",
		"player_spawn_pos": Vector2(52,90),
		"enemies": [ # Enemies that will appear in this level
			"res://game/actor/enemy/enemy.tscn",
			"mob2",
			"mob3",
		],
		"enemy_spawn_pos": {
			"G0": Vector2(48,156),
			"G1": Vector2(175,158),
			"G2": Vector2(295,157),
		},
		
	}
]

var current_level: int
var current_tiltemap: TileMap
var _player_spawn_point: Vector2
var current_wave: int = 0
var total_waves: int = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Load level
	print(str('level ', self.current_level, ' is ready.'))
		


func load_mobs(lvl_num: int = 0, wave_num: int = 0) -> void:
	print(current_level)
	self.spawn_mob(LEVEL_DATA[(lvl_num- 1)]["enemies"][0], LEVEL_DATA[(lvl_num -1)]["enemy_spawn_pos"]["G0"])
	

func set_current_level(lvl: int) -> void:
	self.current_level = lvl

func load_level(lvl_num: int) -> void:
	print(str("Loading level ", lvl_num, "."))
	_load_level_tilemap(lvl_num)

func get_mob_count() -> int:
	return self.enemy_container.get_child_count()

func get_player_start_pos() -> Vector2:
	return LEVEL_DATA[self.current_level - 1].player_spawn_pos

func _load_level_tilemap(level: int) -> void:
	var tilemap: TileMap = load(LEVEL_DATA[(level - 1)].tilemap_path).instantiate()
	$TilemapHolder.add_child(tilemap)

func _check_for_completion() -> void:
	if self.enemy_container.get_child_count() == 0:
		print('all dead signal')
		self.emit_signal("all_dead")

func start_wave(wave_n: int) -> void:
	print(str('starting wave ', wave_n))
	pass

func spawn_mob(e_type: String, spwan_loc: Vector2) -> void:
	var new_e: Enemy = load(e_type).instantiate()
	new_e.has_died.connect(self.remove_mob)
	new_e.global_position = spwan_loc
	self.enemy_container.add_child(new_e)

func remove_mob(e: Enemy) -> void:
	self.enemy_container.remove_child(e)
	_check_for_completion()

func _on_wave_completed() -> void:
	if self.current_wave < self.total_waves:
		self.emit_signal("wave_completed")
	else:
		self.emit_signal("level_completed")
