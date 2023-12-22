extends Node2D
class_name GameEndScreen

@onready var main_menu_path := "res://menu/main_menu.tscn"
@onready var level_scene_path := "res://level/level.tscn"

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fire_weapon"):
		_on_restart_button()
		
	if event.is_action_pressed("fire_bomb"):
		_on_main_menu_button()


func _on_restart_button() -> void:
	AudioPlayer.play_sfx(AudioPlayer.mission_start_sfx)
	AudioPlayer.stop_bgm()
	# print("clicked restart")
	await get_tree().create_timer(0.5).timeout
	GameState.restore_default_game_state()
	GameState.start_timer()
	
	AudioPlayer.play_bgm(AudioPlayer.game_music)
	get_tree().change_scene_to_file(level_scene_path)
	get_tree().paused = false
	queue_free()


func _on_main_menu_button() -> void:
	AudioPlayer.play_sfx(AudioPlayer.fuel_burning_2_sfx, 0.8)
	AudioPlayer.stop_bgm()
	# print("clicked main menu")
	await get_tree().create_timer(0.5).timeout
	GameState.restore_default_game_state()

	AudioPlayer.play_bgm(AudioPlayer.intro_music)
	get_tree().change_scene_to_file(main_menu_path)
	get_tree().paused = false
	queue_free()
