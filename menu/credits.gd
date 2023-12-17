extends Node

const main_menu_scene_path = "res://menu/main_menu.tscn"

# Called when the node enters the scene tree for the first time.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu_back"):
		get_tree().change_scene_to_file(main_menu_scene_path)


func _on_button_button_up():
	get_tree().change_scene_to_file(main_menu_scene_path)
