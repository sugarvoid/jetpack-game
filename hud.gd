extends CanvasLayer

@onready var lbl_score: Label = get_node("LblScore")
@onready var lbl_lives: Label = get_node("LblLevel")
@onready var lbl_level: Label = get_node("LblLevel")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_score(12)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _update_score(num: int) -> void:
	#TODO: Pad zeros 3
	self.lbl_score.text = str("Score: ", ("%03d" % num))
	
