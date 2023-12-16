extends Node

########### Variables

# load target physics fps
var expected_fps = ProjectSettings.get_setting("physics/common/physics_fps")

# once you run out -> you lose
var frames_left = 0

# just in case we want to suspend the frame deduction
var pause_frames_left = 0

# only deduct frames, if the variable is true
# you need to set this to false when pausing the game (and probably while the char is in a shop)
var is_running = true




########## Functions

# Called when the node enters the scene tree for the first time.
func _ready():
	frames_left = 1000
	pass # Replace with function body.


func _physics_process(_delta):
	# if we have pause frames, don't tick down the regular frames
	if pause_frames_left > 0:
		pause_frames_left = pause_frames_left - 1
		pass
	else:
		start_timer()
	
	if is_running:
		frames_left = frames_left - 1
		
	if frames_left % 100 == 0:
		print("frames_left %s" % frames_left)

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
	frames_left += num_frames
