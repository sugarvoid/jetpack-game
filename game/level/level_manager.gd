class_name Level_Manager
extends Node2D

signal on_done
signal all_dead
signal wave_completed(wave: int)
signal level_completed(lvl: int)

@onready var tmr_level_start: Timer = get_node("TmrLevelStart")
@onready var tmr_wave_delay: Timer = get_node("TmrWaveDelay")
@onready var ani_player: AnimationPlayer = get_node("AnimationPlayer")

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

var _current_level: int
var current_tiltemap: TileMap
var _player_spawn_point: Vector2
var current_wave: int = 0
const TOTAL_WAVES: int = 3

func get_current_lvl() -> int:
	return self._current_level

func _ready() -> void:
	#Load level
	pass

func load_mobs(lvl_num: int = 0, wave_num: int = 0) -> void:
	print(_current_level)
	self.spawn_mob(LEVEL_DATA[(lvl_num- 1)]["enemies"][0], LEVEL_DATA[(lvl_num -1)]["enemy_spawn_pos"]["G0"])

func set_current_level(lvl: int) -> void:
	self._current_level = lvl

func load_level(lvl_num: int) -> void:
	print(str("Loading level ", lvl_num, "."))
	_load_level_tilemap(lvl_num)

func get_mob_count() -> int:
	return self.enemy_container.get_child_count()

func get_player_start_pos() -> Vector2:
	return LEVEL_DATA[self._current_level - 1].player_spawn_pos

func _load_level_tilemap(level: int) -> void:
	var tilemap: TileMap = load(LEVEL_DATA[(level - 1)].tilemap_path).instantiate()
	$TilemapHolder.add_child(tilemap)

func _check_for_completion() -> void:
	if self.enemy_container.get_child_count() == 0:
		print('all dead signal')
		self.emit_signal("all_dead")

func start_level(lvl: int) -> void:
	print("starting level timer...")
	self.ani_player.play("count_down")
	# self.tmr_wave_delay.start(4)
	await self.ani_player.animation_finished
	print(str('starting level: ', lvl))
	current_wave = 1 # set first wave 
	start_wave(current_wave)


func start_wave(wave_n: int) -> void:
	print(str('starting wave: ', wave_n))
	self.load_mobs(wave_n)


func spawn_mob(e_type: String, spwan_loc: Vector2) -> void:
	var new_e: Enemy = load(e_type).instantiate()
	new_e.has_died.connect(self.remove_mob)
	new_e.global_position = spwan_loc
	self.enemy_container.add_child(new_e)

func remove_mob(e: Enemy) -> void:
	self.enemy_container.remove_child(e)
	_check_for_completion()

func _on_wave_completed() -> void:
	if self.current_wave < self.TOTAL_WAVES:
		self.emit_signal("wave_completed", current_wave)
		current_wave += 1 # Go to next wave
		self.start_wave(current_wave)
	else:
		self.current_level += 1
		self.emit_signal("level_completed", _current_level)
		start_level(_current_level)
