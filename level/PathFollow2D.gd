extends PathFollow2D
## Moves the enemy along the path
##
## 

@export var speed := 0.4
@export var delete_at_end := true


func _physics_process(delta: float) -> void:
	progress_ratio += delta * speed
	
	if delete_at_end:
		if is_equal_approx(progress_ratio, 1.0):
			for child in get_children():
				child.queue_free()
	

func slowdown_path_follower_to_a_halt() -> void:
	var tween := create_tween()
	tween.set_process_mode(Tween.TWEEN_PROCESS_IDLE)
	tween.tween_property(self, "speed", 0.0, 0.5)
