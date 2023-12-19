extends Node

const options_scene_path = "res://menu/options_menu.tscn"
const credits_scene_path = "res://menu/credits_menu.tscn"
const game_scene_path = "res://level/level.tscn"

func _ready():
	AudioPlayer.disable_lpf()
	GameState.pause_timer()

# Called when the node enters the scene tree for the first time.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu_back"): 
		load_option_scene()
		
	if event.is_action_pressed("fire_weapon"):
		load_game_scene()
		
	if event.is_action_pressed("fire_bomb"):
		load_credit_scene()


func load_game_scene():
	get_tree().change_scene_to_file(game_scene_path)
	AudioPlayer.stop_bgm()
	AudioPlayer.play_sfx(AudioPlayer.mission_start_sfx)
	AudioPlayer.play_bgm(AudioPlayer.game_music)

func load_option_scene():
	get_tree().change_scene_to_file(options_scene_path)
	
func load_credit_scene():
	get_tree().change_scene_to_file(credits_scene_path)
