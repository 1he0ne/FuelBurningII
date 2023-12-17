extends Node2D
## Spawns the player bullets 
##
## Calls all children to fire bullets on player input

var player_fire_sfx = preload("res://audioAssets/playershot1.wav")

# Called when the node enters the scene tree for the first time.
func _input(event: InputEvent) -> void:
	if !event.is_action_pressed("fire_weapon"): return
	
	AudioPlayer.play_sfx(player_fire_sfx, 0.5)
	
	for gun in get_children():
		gun._spawn_node()
