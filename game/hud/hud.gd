class_name HUD
extends CanvasLayer

@onready var lbl_score: Label = get_node("LblScore")
@onready var lbl_lives: Label = get_node("LblLevel")
@onready var lbl_level: Label = get_node("LblLevel")
@onready var pgb_player_heat: TextureProgressBar = get_node("PlayerHeatBar")

const RED_REGION: Rect2 = Rect2(8,0,8,8)
const GREEN_REGION: Rect2 = Rect2(0,0,8,8)

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
		_change_heat_bar_color(RED_REGION)
	else:
		_change_heat_bar_color(GREEN_REGION)

func _get_percent_of_float(f: float, percent: float) -> float:
	return (percent / 100) * f

func _change_heat_bar_color(region: Rect2) -> void:
	self.pgb_player_heat.texture_progress.set_region(region)


func update_score(num: int) -> void:
	self.lbl_score.text = str("Score: ", ("%03d" % num))


func update_level(num: int) -> void:
	self.lbl_level.text = str("Level: ", ("%03d" % num))


func update_heat_bar_max_value(n: float) -> void:
	self.pgb_player_heat.max_value = int(n)


func update_jetpack_heat_bar(amount: float) -> void:
	self.pgb_player_heat.value = amount
