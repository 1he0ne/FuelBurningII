extends Node2D
## Spawns the player bullets 
##
## Calls all children to fire bullets on player input


# Called when the node enters the scene tree for the first time.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fire_weapon"):
		for gun in get_children():
			gun._spawn_node()
			

