extends Node2D



const p_Player: PackedScene = preload("res://game/actor/player/player.tscn")
@onready var projectile_manager: ProjectileManager = get_node("ProjectileManager")

var player: Player


func _ready() -> void:
	self.add_player_to_level()
	self.player.request_bullet.connect(self._add_projectile)
	


func add_player_to_level() -> void:
	self.player = p_Player.instantiate()
	var spawn_point: Vector2 = $Level_1/PlayerSpawn.global_position
	self.player.global_position = spawn_point
	add_child(self.player)
	

func _add_projectile(weapon: Weapon) -> void:
	projectile_manager.add_player_bullet_to_screen(weapon)
