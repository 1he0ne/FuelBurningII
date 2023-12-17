extends PathFollow2D
## Moves the enemy along the path
##
## 


@export var speed = 0.4


func _physics_process(delta: float) -> void:
	progress_ratio += delta * speed
	

func slowdown_path_follower_to_a_hault():
	var tween = create_tween()
	tween.set_process_mode(Tween.TWEEN_PROCESS_IDLE)
	tween.tween_property(self, "speed", 0.0, 0.5)
	
