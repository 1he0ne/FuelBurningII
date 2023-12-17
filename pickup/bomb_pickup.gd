extends Node2D
class_name BombPickup

@onready var _animated_sprite = $AnimatedSprite2D


func _ready():
	_animated_sprite.play("default")
