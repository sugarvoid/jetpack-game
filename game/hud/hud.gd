class_name HUD
extends CanvasLayer

@onready var lbl_score: Label = get_node("LblScore")
@onready var lbl_lives: Label = get_node("LblLevel")
@onready var lbl_level: Label = get_node("LblLevel")
@onready var pgb_player_heat: ProgressBar = get_node("PlayerHeatBar")

func _ready() -> void:
	pass


func update_score(num: int) -> void:
	self.lbl_score.text = str("Score: ", ("%03d" % num))


func update_level(num: int) -> void:
	self.lbl_level.text = str("Level: ", ("%03d" % num))

func update_heat_bar_max_value(n: float) -> void:
	self.pgb_player_heat.max_value = int(n)

func update_jetpack_heat_bar(amount: float) -> void:
	self.pgb_player_heat.value = amount
