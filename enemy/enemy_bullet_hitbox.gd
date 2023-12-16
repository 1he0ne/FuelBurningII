extends Area2D
## objective for player to shoot
##
##


@export var fadeout_time = 0.4


func _on_area_entered(area: Area2D) -> void:
	print("enemy hit")
	
	fade_out_and_delete(get_parent())
	
	%ExplosionAnimation.position = global_position
	%ExplosionAnimation.play()
	

func fade_out_and_delete(node):
	var tween = create_tween()
	tween.set_process_mode(Tween.TWEEN_PROCESS_IDLE)
	tween.tween_property(node, "modulate" , Color(1, 1, 1, 0), fadeout_time)
	tween.tween_callback(node.queue_free)
	
