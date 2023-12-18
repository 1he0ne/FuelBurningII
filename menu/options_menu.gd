extends Node2D

const game_scene_path = "res://level/level.tscn"
const main_menu_scene_path = "res://menu/main_menu.tscn"

var sfx_sample_sound = preload("res://audioAssets/explode1.wav")

@onready var sfxBar = $VBoxContainer/sfx_volume_bar as ProgressBar
@onready var bgmBar = $VBoxContainer/bgm_volume_bar as ProgressBar
@onready var selectedBar = sfxBar


func _ready():
	sfxBar.value = AudioPlayer.sfx_volume
	bgmBar.value = AudioPlayer.bgm_volume
	
	_on_select_bar(sfxBar)
	
	AudioPlayer.enable_lpf()
	GameState.pause_timer()
	
	get_tree().paused = true
	

	

# Called when the node enters the scene tree for the first time.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu_back"): 
		_on_back_button_pressed()
		
	if event.is_action_pressed("move_left"):
		if selectedBar == sfxBar:
			_on_sfx_minus()
		if selectedBar == bgmBar:
			_on_bgm_minus()
		
	if event.is_action_pressed("move_right"):
		if selectedBar == sfxBar:
			_on_sfx_plus()
		if selectedBar == bgmBar:
			_on_bgm_plus()
		
	# TODO: triggers erratically when using controller	
	if event.is_action_released("move_up") || event.is_action_released("move_down"):
		if selectedBar == sfxBar:
			_on_select_bar(bgmBar)
		else:
			_on_select_bar(sfxBar)


func _on_select_bar(bar_to_select: ProgressBar):
	if bar_to_select == bgmBar:
		sfxBar.modulate = Color.WHITE
		selectedBar = bgmBar
		bgmBar.modulate = Color.AQUA
	else:
		bgmBar.modulate = Color.WHITE
		selectedBar = sfxBar
		sfxBar.modulate = Color.AQUA
	
func _mod_sfx_volume(volume_to_add: float):
	AudioPlayer.sfx_volume = clampf(AudioPlayer.sfx_volume + volume_to_add, 0.0, 100.0)
	AudioPlayer.set_sfx_volume()
	sfxBar.value = AudioPlayer.sfx_volume
	AudioPlayer.play_sfx(sfx_sample_sound)
	_on_select_bar(sfxBar)

func _on_sfx_minus():
	_mod_sfx_volume(-5.0)

func _on_sfx_plus():
	_mod_sfx_volume(+5.0)

func _on_bgm_minus():
	AudioPlayer.bgm_volume = clampf(AudioPlayer.bgm_volume - 5.0, 0.0, 100.0)
	AudioPlayer.set_bgm_volume()
	bgmBar.value = AudioPlayer.bgm_volume
	_on_select_bar(bgmBar)

func _on_bgm_plus():
	AudioPlayer.bgm_volume = clampf(AudioPlayer.bgm_volume + 5.0, 0.0, 100.0)
	AudioPlayer.set_bgm_volume()
	bgmBar.value = AudioPlayer.bgm_volume
	_on_select_bar(bgmBar)


func _on_back_button_pressed():
	get_tree().paused = false
	AudioPlayer.disable_lpf()
	if get_meta("is_ingame_menu"):
		print("ingame")
		queue_free()
	else:
		print("not ingame")
		get_tree().change_scene_to_file(main_menu_scene_path)
