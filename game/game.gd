extends Node2D

@onready var hud: HUD = get_node("HUD")
@onready var level_manager: Level_Manager = get_node("Level_Manager")

const p_Player: PackedScene = preload("res://game/actor/player/player.tscn")

var projectile_manager: ProjectileManager
var current_level: int
var player: Player
var player_lives: int
var player_score: int


func _ready() -> void:
	self._start_game()
	self.current_level = 1
	self.level_manager.set_current_level(current_level)
	self.level_manager.load_level(self.current_level)

	self.projectile_manager = preload("res://game/manager/projectile_manager/projectile_manager.tscn").instantiate()
	self.add_child(projectile_manager)
	self.add_player_to_level()
	self.hud.update_heat_bar_max_value(self.player.get_jetpack_max_heat())
	self.hud.update_level(current_level)
	
	self.player.request_bullet.connect(self._add_projectile)
	self.hud.update_heat_high_value()


func _physics_process(delta: float) -> void:
	self.hud.update_jetpack_heat_bar(self.player.get_jetpack_heat())

#func _input(event: InputEvent) -> void:
#	if event.is_action_released("ui_cancel"):
#		_pause_game()

func _connect_child_signals() -> void:
	self.level_manager.wave_completed.connect(self._on_wave_completed)

func _start_level(level) -> void:
	pass

# Might rename to _restart_game()
func _start_game() -> void:
	self.current_level = 1
	# level_manager.load_mobs(current_level)
	level_manager.start_level(current_level)

#func _load_level(lvl_num: int) -> Level:
#	var level: Level = load(_get_level_path_string(lvl_num)).instantiate()
#	level.level_completed.connect(self._on_level_completion)
#	self.add_child(level)
#	return level
#func _pause_game() -> void:
#	self.is_paused = !self.is_paused
#	_toggle_mouse_mode()
#	self.hud.pause_game(self.is_paused)

func add_player_to_level() -> void:
	self.player = p_Player.instantiate()
	var spawn_point: Vector2 = self.level_manager.get_player_start_pos()
	self.player.global_position = spawn_point
	add_child(self.player)


func _add_projectile(weapon: Weapon) -> void:
	projectile_manager.add_player_bullet_to_screen(weapon)

func _on_level_completion(lvl: int) -> void:
	# unload current
	# load next one
	self.current_level_number += 1
	self.hud.update_level(level_manager.get_current_level())
	print(str('level ', lvl, 'is done.'))

func _on_wave_completed(wave: int) -> void:
	print(str('Wave ', wave, 'complted.'))
