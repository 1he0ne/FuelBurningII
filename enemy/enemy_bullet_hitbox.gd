extends Area2D
## objective for player to shoot
##
##


@export var fadeout_time = 0.4

var is_alive := true


func _ready():
	%ExplosionAnimation.visible = false


func _on_area_entered(area: Area2D) -> void:
	print("enemy hit")
	
	if is_alive:
		is_alive = false 
		fade_out_and_delete(get_parent())
		
		%Guns.queue_free() 
		
		%ExplosionAnimation.position = global_position
		%ExplosionAnimation.visible = true
		%ExplosionAnimation.play()
	

func fade_out_and_delete(node):
	var tween = create_tween()
	tween.set_process_mode(Tween.TWEEN_PROCESS_IDLE)
	tween.tween_property(node, "modulate" , Color(1, 1, 1, 0), fadeout_time)
	tween.tween_callback(node.queue_free)
	
