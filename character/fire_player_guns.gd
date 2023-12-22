extends Node2D
## Spawns the player bullets 
##
## Calls all children to fire bullets on player input

var player_fire_sfx := preload("res://audioAssets/playershot1.wav")


var max_cooldown_frames: int = 20
var current_cooldown: int = 0

var is_firing := false

func _physics_process(_delta: float) -> void:
	current_cooldown = clampi(current_cooldown - 1, 0, max_cooldown_frames)
	
	if is_firing && current_cooldown <= 0:
		AudioPlayer.play_sfx(player_fire_sfx, 0.5)
		current_cooldown = max_cooldown_frames
		for gun in get_children():
			gun._spawn_node()

	#print("is_firing: %s, current_cooldown: %s" % [is_firing, current_cooldown])
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fire_weapon"): is_firing = true
	if event.is_action_released("fire_weapon"): is_firing = false

	

