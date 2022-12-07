extends Node2D

@onready var HUD: HUD = get_node("HUD")
@onready var projectile_manager: ProjectileManager = get_node("ProjectileManager")

const p_Player: PackedScene = preload("res://game/actor/player/player.tscn")

var current_level: int
var player: Player

func _ready() -> void:
	self.current_level = 1
	self.HUD.update_level(current_level)
	self.add_player_to_level()
	self.player.request_bullet.connect(self._add_projectile)


func _physics_process(delta: float) -> void:
	self.HUD.update_jetpack_heat_bar(self.player.jet_pack_heat)


func add_player_to_level() -> void:
	self.player = p_Player.instantiate()
	var spawn_point: Vector2 = $Level_1/PlayerSpawn.global_position
	self.player.global_position = spawn_point
	add_child(self.player)


func _add_projectile(weapon: Weapon) -> void:
	projectile_manager.add_player_bullet_to_screen(weapon)
