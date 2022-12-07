class_name HUD
extends CanvasLayer

@onready var lbl_score: Label = get_node("LblScore")
@onready var lbl_lives: Label = get_node("LblLevel")
@onready var lbl_level: Label = get_node("LblLevel")

func _ready() -> void:
	pass


func update_score(num: int) -> void:
	self.lbl_score.text = str("Score: ", ("%03d" % num))


func update_level(num: int) -> void:
	self.lbl_level.text = str("Level: ", ("%03d" % num))


func update_jetpack_heat_bar(amount: float) -> void:
	$TextureProgressBar.value = amount
