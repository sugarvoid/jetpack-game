class_name Weapon
extends Node2D

signal can_shoot_bullet(weapon: Weapon)

enum BULLET_TYPE {
	WATER,
	COMPOST,
	DAMAGE,
}

enum WEAPON_TYPE {
	FARMING,
	COMBACT,
}

enum WEAPON_SUBTYPE {
	PROJECTILE,
	MELEE,
}

@onready var muzzle = get_node("Muzzle")

var weapon_ID: String
var weapon_type: int
var weapon_subtype: int
var bullet_speed: float
var bullet_life: float
var bullet_sprite_frame: int
var reload_time: float
var magazine_size: int
var bullets_left: int
var spread: float
var bullet_ID: String
var damage: int


func _ready() -> void:

	bullet_speed = 300
	bullet_life = 3.5
	reload_time = 2.5
	spread = 0.1
	magazine_size = 9
	bullets_left = 9
	bullet_sprite_frame = 1


func primary_action() -> void:
	assert(false, "Overide method")
	
func secondary_action() -> void:
	assert(false, "Overide method")

func set_damage_amount(n: int) -> void:
	self.damage = n

func fire_bullet() -> void:
	if bullets_left > 0:
		emit_signal("can_shoot_bullet", self)
		print('emitted can shoot signal')
		self.bullets_left -= 1
		if self.bullets_left == 0:
			return

func reload() -> void:
	self.bullets_left = self.magazine_size


