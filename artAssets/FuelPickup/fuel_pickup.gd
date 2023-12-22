extends Node2D
class_name FuelPickup

@onready var _animated_sprite:AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	_animated_sprite.play("default")
