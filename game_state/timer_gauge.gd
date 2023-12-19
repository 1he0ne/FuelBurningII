extends Node2D

@onready var label = $RichTextLabel as RichTextLabel
@onready var gauge_needle_shadow = $NeedleShadow as Sprite2D
@onready var gauge_needle = $FuelGaugeNeedle as Sprite2D

var min_rotation = 45.0+360.0
var max_rotation = 135.0

func _ready():
	GameState.start_timer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	label.text = "[center]Remaining time: %s[center]" % _frames_to_time(GameState.get_remaining_frames())
	var degrees = _frames_to_deg(GameState.get_remaining_frames())
	gauge_needle_shadow.rotation_degrees = degrees
	gauge_needle.rotation_degrees = degrees
	
	

func _frames_to_deg(frames: int) -> float:
	var weight = (frames as float) / (GameState.MAX_FRAMES as float)
	return lerpf(max_rotation, min_rotation, weight)

func _frames_to_time(frames: int) -> String:
	var fractions =  (frames % 60) / 60.0 * 100.0 # convert frames to fractional seconds
	frames = frames / 60
	
	var seconds = frames % 60
	frames = frames / 60
	
	var minutes = frames % 60
	frames = frames / 60
	
	#var hours = frames # you could add more modulo and divisions for days, etc.
	return "%02d:%02d.%02ds" % [minutes, seconds, fractions]
