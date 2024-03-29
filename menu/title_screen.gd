extends Node2D


const main_menu_path := "res://menu/main_menu.tscn"

var title_flash_counter := 0

func _ready() -> void:
	GameState.pause_timer()
	AudioPlayer.play_sfx(AudioPlayer.fuel_burning_2_sfx, 0.7)
	await get_tree().create_timer(3.0).timeout
	AudioPlayer.play_bgm(AudioPlayer.title_music, 0.6) # enable, once title music has been added

func _physics_process(_delta: float) -> void:
	title_flash_counter = title_flash_counter + 1
	$RichTextLabel.visible = title_flash_counter % 60 > 15
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fire_weapon") || event.is_action_pressed("fire_bomb") || event.is_action_pressed("menu_back"): 
		AudioPlayer.play_sfx(AudioPlayer.press_start_sfx, 0.8)
		AudioPlayer.stop_bgm()
		await get_tree().create_timer(0.5).timeout
		load_game_scene()
		
func load_game_scene() -> void:
	AudioPlayer.play_bgm(AudioPlayer.intro_music, 1)
	get_tree().change_scene_to_file(main_menu_path)
