extends Node2D
class_name GameEndScreen

@onready var main_menu_path:String = "res://menu/main_menu.tscn"
@onready var level_scene_path:String = "res://level/level.tscn"



func _on_restart_button() -> void:
	print("clicked restart")
	GameState.restore_default_game_state()
	GameState.start_timer()
	AudioPlayer.play_sfx(AudioPlayer.mission_start_sfx)
	AudioPlayer.play_bgm(AudioPlayer.game_music)
	get_tree().change_scene_to_file(level_scene_path)
	get_tree().paused = false
	queue_free()


func _on_main_menu_button() -> void:
	print("clicked main menu")
	GameState.restore_default_game_state()
	AudioPlayer.play_sfx(AudioPlayer.fuel_burning_2_sfx, 0.8)
	AudioPlayer.play_bgm(AudioPlayer.intro_music)
	get_tree().change_scene_to_file(main_menu_path)
	get_tree().paused = false
	queue_free()
