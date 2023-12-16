extends Node2D
class_name Bullet
## Moves in a set direction
##
##

@export var velocity = Vector2(0.0, 5.0)
@export var damage = float(2.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += velocity
