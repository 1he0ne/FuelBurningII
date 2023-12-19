extends Node

@onready var viewport = get_viewport()
@onready var game_size = Vector2(100, 100)#Vector2(ProjectSettings.get_setting("display/window/size/width"), ProjectSettings.get_setting("display/window/size/height"))

func _ready():
	get_tree().get_root().size_changed.connect(resize_viewport)

func resize_viewport():
	var new_size = get_window().size
	var scale_factor

	if new_size.x < game_size.x:
		scale_factor = game_size.x/new_size.x
		new_size = Vector2(new_size.x*scale_factor, new_size.y*scale_factor)
	if new_size.y < game_size.y:
		scale_factor = game_size.y/new_size.y
		new_size = Vector2(new_size.x*scale_factor, new_size.y*scale_factor)
	
	viewport.set_size_override(true, new_size)
