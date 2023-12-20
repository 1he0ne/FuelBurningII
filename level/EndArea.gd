extends Area2D
## Moves in a set direction
##
##

@export var warning_scene:PackedScene
@export var time_paused := 3.0

var done := false


func _on_area_entered(_area: Area2D) -> void:
	#print("character has triggered pausing")
	if done:
		queue_free()
		return
		
	done = true

	var new_scene := warning_scene.instantiate()
	add_child(new_scene)
	
	_pause_for_a_time.call_deferred()


func _pause_for_a_time() -> void:
	get_tree().paused = true
	
	var unpause := func() -> void: get_tree().paused = false
	await get_tree().create_timer(time_paused).timeout.connect(unpause)
