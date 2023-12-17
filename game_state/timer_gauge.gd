extends Node2D

@onready var label = $RichTextLabel as RichTextLabel



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label.text = "Remaining time: %s" % _frames_to_time(GameState.get_remaining_frames())

func _frames_to_time(frames: int) -> String:
	var fractions =  (frames % 60) / 60.0 * 100.0 # convert frames to fractional seconds
	frames = frames / 60
	
	var seconds = frames % 60
	frames = frames / 60
	
	var minutes = frames % 60
	frames = frames / 60
	
	var hours = frames # you could add more modulo and divisions for days, etc.
	return "%02d h, %02d m, %02d.%02d s" % [hours, minutes, seconds, fractions]
