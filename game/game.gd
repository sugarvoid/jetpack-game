extends Node2D

@onready var hud: HUD = get_node("HUD")
@onready var projectile_manager: ProjectileManager = get_node("ProjectileManager")

const p_Player: PackedScene = preload("res://game/actor/player/player.tscn")

var current_level: int
var player: Player

func _ready() -> void:
	### Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	# Input.set_custom_mouse_cursor(preload("res://game/hud/1x1.png"))
	self.add_player_to_level()
	self.current_level = 1
	print(self.hud)
	self.hud.update_heat_bar_max_value(self.player.get_jetpack_max_heat())
	self.hud.update_level(current_level)
	
	self.player.request_bullet.connect(self._add_projectile)


func _physics_process(delta: float) -> void:
	self.hud.update_jetpack_heat_bar(self.player.get_jetpack_heat())


func add_player_to_level() -> void:
	self.player = p_Player.instantiate()
	var spawn_point: Vector2 = $Level_1/PlayerSpawn.global_position
	self.player.global_position = spawn_point
	add_child(self.player)


func _add_projectile(weapon: Weapon) -> void:
	projectile_manager.add_player_bullet_to_screen(weapon)
