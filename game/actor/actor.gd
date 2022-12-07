class_name Actor
extends CharacterBody2D



var speed: float 

var jump_velocity: float

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

