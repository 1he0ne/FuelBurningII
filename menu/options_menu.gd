extends Node2D

const game_scene_path = "res://level/level.tscn"
const main_menu_scene_path = "res://menu/main_menu.tscn"



func _ready():
	($sfx_volume_bar as ProgressBar).value = AudioPlayer.sfx_volume

# Called when the node enters the scene tree for the first time.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu_back"): 
		get_tree().change_scene_to_file(main_menu_scene_path) 
		# how do we decide if came here from the game or from the menu?
		
	if event.is_action_pressed("move_left"):
		AudioPlayer.sfx_volume = clampf(AudioPlayer.sfx_volume - 5.0, 0.0, 100.0)
		AudioPlayer.set_sfx_volume()
		($sfx_volume_bar as ProgressBar).value = AudioPlayer.sfx_volume
		
	if event.is_action_pressed("move_right"):
		AudioPlayer.sfx_volume = clampf(AudioPlayer.sfx_volume + 5.0, 0.0, 100.0)
		AudioPlayer.set_sfx_volume()
		($sfx_volume_bar as ProgressBar).value = AudioPlayer.sfx_volume
