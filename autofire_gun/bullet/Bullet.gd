extends Node2D
## Moves in a set direction
##
##

@export var velocity = Vector2(0.0, 5.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += velocity
