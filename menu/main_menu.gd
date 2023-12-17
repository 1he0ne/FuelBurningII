extends Node


const options_scene_path = "res://menu/options_menu.tscn"
const credits_scene_path = "res://menu/credits_menu.tscn"
const game_scene_path = "res://level/level.tscn"

# Called when the node enters the scene tree for the first time.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu_back"): 
		get_tree().change_scene_to_file(options_scene_path)
		
	if event.is_action_pressed("fire_weapon"):
		get_tree().change_scene_to_file(game_scene_path)
		
	if event.is_action_pressed("fire_bomb"):
		get_tree().change_scene_to_file(credits_scene_path)
