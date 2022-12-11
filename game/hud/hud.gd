class_name HUD
extends CanvasLayer

@onready var lbl_score: Label = get_node("LblScore")
@onready var lbl_lives: Label = get_node("LblLevel")
@onready var lbl_level: Label = get_node("LblLevel")
@onready var pgb_player_heat: TextureProgressBar = get_node("PlayerHeatBar")

var heat_high_value: float

func _ready() -> void:
	print(pgb_player_heat.max_value)
	print(self.heat_high_value)
	

func update_heat_high_value() -> void:
	var bar_max = self.pgb_player_heat.max_value
	self.heat_high_value = _get_percent_of_float(bar_max, 80.0)

func _process(delta: float) -> void:
	print(pgb_player_heat.max_value)
	if pgb_player_heat.value >= self.heat_high_value:
		self.pgb_player_heat.texture_progress.set_region(Rect2(8,0,8,8))
	else:
		self.pgb_player_heat.texture_progress.set_region(Rect2(0,0,8,8))

func _get_percent_of_float(f: float, percent: float) -> float:
	return (percent / 100) * f

func _texture_to_red() -> void:
	# Rect2(0, 0, 0, 0)
	# green = (0,0,8,8)
	# red = (8,0,8,8)
	print(self.pgb_player_heat.texture_progress.get_region())
	self.pgb_player_heat.texture_progress.set_region(Rect2(8,0,8,8))


func update_score(num: int) -> void:
	self.lbl_score.text = str("Score: ", ("%03d" % num))


func update_level(num: int) -> void:
	self.lbl_level.text = str("Level: ", ("%03d" % num))


func update_heat_bar_max_value(n: float) -> void:
	self.pgb_player_heat.max_value = int(n)


func update_jetpack_heat_bar(amount: float) -> void:
	self.pgb_player_heat.value = amount
