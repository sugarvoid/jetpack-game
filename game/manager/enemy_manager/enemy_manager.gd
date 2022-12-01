class_name EnemyManager
extends Node2D

@onready var enemy_container: Node2D = get_node("EnemyContainer")


var _current_mobs: int


func get_mob_count() -> int:
	return self.enemy_container.get_child_count()
