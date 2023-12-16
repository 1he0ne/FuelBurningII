extends PathFollow2D
## Moves the enemy along the path
##
## 


@export var speed = 0.4


func _physics_process(delta: float) -> void:
	progress_ratio += delta * speed
