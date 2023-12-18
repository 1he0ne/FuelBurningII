extends Node2D


const main_menu_path = "res://menu/main_menu.tscn"

var title_flash_counter = 0

func _ready():
	# AudioPlayer.play_bgm(AudioPlayer.title_music) # enable, once title music has been added
	pass


func _physics_process(delta):
	title_flash_counter = title_flash_counter + 1
	$RichTextLabel.visible = title_flash_counter % 60 > 15
	
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fire_weapon") || event.is_action_pressed("fire_bomb") || event.is_action_pressed("menu_back"): 
		load_game_scene()
		

func load_game_scene():
	get_tree().change_scene_to_file(main_menu_path)
	AudioPlayer.play_bgm(AudioPlayer.game_music)
