extends Control

const game_scene_path = "res://level.tscn"
const map_scene_path = "res://map.tscn"
const credit_scene_path = "res://menu/credits.tscn"

func _on_start_game_button_up():
	get_tree().change_scene_to_file(game_scene_path)
	

func _on_show_map_button_up():
	get_tree().change_scene_to_file(map_scene_path)

