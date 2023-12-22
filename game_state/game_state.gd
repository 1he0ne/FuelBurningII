extends Node



########### Constants
# load target physics fps
@onready var EXPECTED_FPS := 60#ProjectSettings.get_setting("physics/common/physics_fps")

# 20 seconds max (at expected FPS)
@onready var MAX_FRAMES := 20*EXPECTED_FPS

@onready var DEFAULT_FRAMES_ON_GAME_START := MAX_FRAMES

@onready var DEFAULT_BOMB_COUNT := 1
@onready var DEFAULT_EXTRA_LIVES := 3

########### Variables

# only deduct frames, if the variable is true
# you need to set this to false when pausing the game (and probably while the char is in a shop)
var is_running: bool
var is_game_over: bool

var num_bombs: int
var num_extra_lives: int
# once you run out -> you lose
var frames_left: int

var camera_reference: Camera2D

var _god_mode: bool = false

########## Functions

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	restore_default_game_state()
	pass # Replace with function body.

func restore_default_game_state() -> void:
	is_running = false
	is_game_over = false	
	frames_left = MAX_FRAMES
	num_bombs = DEFAULT_BOMB_COUNT
	num_extra_lives = DEFAULT_EXTRA_LIVES
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("god_mode"): 
		enable_god_mode()
		AudioPlayer.play_sfx(AudioPlayer.press_start_sfx)

func enable_god_mode() -> void:
	_god_mode = true
	frames_left = 999999
	num_bombs = 9999
	num_extra_lives = 9999
	
func lose_game() -> void:
	if !is_game_over:
		var end_screen:GameEndScreen = preload("res://menu/game_end_screen.tscn").instantiate()
		get_node(".").add_child(end_screen)
		(end_screen.get_child(1) as RichTextLabel).text = "[center]MISSION FAIL!!!!"
		end_screen.position = camera_reference.position
		get_tree().paused = true

	is_game_over = true
	
func win_game() -> void:
	if !is_game_over:
		AudioPlayer.play_sfx(AudioPlayer.mission_compree_sfx, 1.5)
		var end_screen:GameEndScreen = preload("res://menu/game_end_screen.tscn").instantiate()
		get_node(".").add_child(end_screen)
		(end_screen.get_child(1) as RichTextLabel).text = "[center]MISSION COMPLETE!\n\nYOU WIN!!!!!"
		end_screen.position = camera_reference.position
		get_tree().paused = true
		
	is_game_over = true


func _physics_process(_delta: float) -> void:
	if is_running:
		frames_left = maxi(frames_left - 1, 0)
		
	if frames_left <= 0 && !is_game_over:
		lose_game()
		
	#if frames_left % 100 == 0:
	#	print("frames_left %s" % frames_left)

func get_remaining_frames() -> int:
	return frames_left
	
func start_timer() -> void:
	is_running = true

func pause_timer() -> void:
	is_running = false
		
func spend_frames(num_frames: int) -> bool:
	if frames_left < num_frames:
		print("not enough frames to spend!")
		return false
	else:
		frames_left -= num_frames
		print("spent %s frames" % num_frames)
		return true
		
func add_frames(num_frames: int) -> void:
	print("added %s frames" % num_frames)
	if !_god_mode:
		frames_left = clampi(frames_left + num_frames, 0, MAX_FRAMES)

func add_bombs(bombs_to_add: int) -> void:
	num_bombs = num_bombs + bombs_to_add
	print(num_bombs)
	
func use_bombs(bombs_to_spend: int) -> bool:
	if num_bombs < bombs_to_spend: return false

	num_bombs = num_bombs-bombs_to_spend
	return true

func add_extra_lives(lives_to_add: int) -> void:
	num_extra_lives += lives_to_add
	
func lose_extra_life() -> bool:
	if num_extra_lives < 1: 
		lose_game()
		return false 
	
	num_extra_lives -= 1
	return true

func seconds_to_frames(seconds: float) -> int:
	return roundi(seconds*EXPECTED_FPS)

func frames_to_seconds(frames: float) -> float:
	var seconds_per_frame := 1.0 / float(EXPECTED_FPS)
	return frames * seconds_per_frame
