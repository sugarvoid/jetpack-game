extends Node2D

@onready var hitbox: Area2D = get_node("Hitbox")
# Called when the node enters the scene tree for the first time.
func _ready():
	self.hitbox.connect("area_entered", self.area_entered)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func area_entered(area: Area2D) -> void:
	if area.has_method("get_class_name"):
		if area.get_class_name() == "Projectile":
			print("bullet hit target")
