extends Node

########### Variables

# load target physics fps
var expected_fps = ProjectSettings.get_setting("physics/common/physics_fps")

# 20 seconds max (at expected 60 FPS)
var max_frames = 20*60
# once you run out -> you lose
var frames_left = 0

# just in case we want to suspend the frame deduction
var pause_frames_left = 0

# only deduct frames, if the variable is true
# you need to set this to false when pausing the game (and probably while the char is in a shop)
var is_running = false


var num_bombs = 1

var num_extra_lives = 3

########## Functions

# Called when the node enters the scene tree for the first time.
func _ready():
	frames_left = 20*60
	pass # Replace with function body.


func _physics_process(_delta):
	# if we have pause frames, don't tick down the regular frames
	if pause_frames_left > 0:
		pause_frames_left = pause_frames_left - 1
		pass
	else:
		start_timer()
	
	if is_running:
		frames_left = maxi(frames_left - 1, 0)
		
	#if frames_left % 100 == 0:
	#	print("frames_left %s" % frames_left)

func get_remaining_frames() -> int:
	return frames_left
	
func get_remaining_pause_frames() -> int:
	return pause_frames_left
	
func start_timer():
	is_running = true

func pause_timer():
	is_running = false
	
func pause_timer_temporarily(frames_to_pause: int):
	pause_frames_left = frames_to_pause
	pause_timer()
	
func spend_frames(num_frames: int) -> bool:
	if frames_left < num_frames:
		print("not enough frames to spend!")
		return false
	else:
		frames_left -= num_frames
		print("spent %s frames" % num_frames)
		return true
		
func add_frames(num_frames: int):
	print("added %s frames" % num_frames)
	frames_left = clampi(frames_left + num_frames, 0, max_frames)


func add_bombs(bombs_to_add: int):
	num_bombs = num_bombs + bombs_to_add
	print(num_bombs)
	
func use_bombs(bombs_to_spend: int) -> bool:
	if num_bombs < bombs_to_spend: return false

	num_bombs = num_bombs-bombs_to_spend
	return true

func add_extra_lives(lives_to_add: int):
	num_extra_lives += lives_to_add
	
func lose_extra_life() -> bool:
	if num_extra_lives < 1: return false # lose the game here
	
	num_extra_lives -= 1
	return true
