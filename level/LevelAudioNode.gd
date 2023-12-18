extends Node
#@onready var option_menu = 
# Called when the node enters the scene tree for the first time.
var object

func _ready():
	GameState.start_timer()
	AudioPlayer.disable_lpf()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu_back") && !is_instance_valid(object): 
		# also pause the game, if this happens!!!!!
		set_meta("options_are_open", true)
		object = preload("res://menu/options_menu.tscn").instantiate()
		object.set_meta("is_ingame_menu", true)
		object.position = %CharacterCamera.position
		print(object.get_meta("is_ingame_menu"))
		get_node(".").add_child(object)
