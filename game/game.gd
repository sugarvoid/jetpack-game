extends Node2D

@onready var hud: HUD = get_node("HUD")
var projectile_manager: ProjectileManager
const p_Player: PackedScene = preload("res://game/actor/player/player.tscn")

const LEVEL_PATH: String = "res://game/level/level_"

const LEVEL_PATHS: Array = [
	"res://game/level/level_1.tscn",
]

var current_level_number: int
var current_level: Level
var player: Player

var player_lives: int
var player_score: int


func _ready() -> void:
	self.current_level_number = 1
	self.current_level = self._load_level(current_level_number)
	### Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	# Input.set_custom_mouse_cursor(preload("res://game/hud/1x1.png"))
	self.projectile_manager = preload("res://game/manager/projectile_manager/projectile_manager.tscn").instantiate()
	self.add_child(projectile_manager)
	self.add_player_to_level()
	self.current_level_number = 1
	print(self.hud)
	self.hud.update_heat_bar_max_value(self.player.get_jetpack_max_heat())
	self.hud.update_level(current_level_number)
	
	self.player.request_bullet.connect(self._add_projectile)


func _physics_process(delta: float) -> void:
	self.hud.update_jetpack_heat_bar(self.player.get_jetpack_heat())

func _start_level(level) -> void:
	pass

func _load_level(lvl_num: int) -> Level:
	var level: Level = load(_get_level_path_string(lvl_num)).instantiate()
	level.all_dead.connect(self._on_level_completion)
	self.add_child(level)
	return level

func _get_level_path_string(lvl_num: int) -> String:
	return str(LEVEL_PATH, lvl_num, ".tscn")

func add_player_to_level() -> void:
	self.player = p_Player.instantiate()
	var spawn_point: Vector2 = self.current_level.get_player_start_pos()
	self.player.global_position = spawn_point
	add_child(self.player)


func _add_projectile(weapon: Weapon) -> void:
	projectile_manager.add_player_bullet_to_screen(weapon)

func _on_level_completion() -> void:
	# unload current
	# load next one
	self.current_level_number += 1
	self.hud.update_level(current_level_number)
	print('level is done')
