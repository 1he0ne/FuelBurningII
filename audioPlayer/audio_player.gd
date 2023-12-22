extends Node

var sfx_channels:Array[AudioStreamPlayer]
var channel_id_to_play_on := 0

var sfx_volume := 80.0
var bgm_volume := 50.0

@onready var title_music := preload("res://audioAssets/bgm/title_track_bgm.ogg")
@onready var intro_music := preload("res://audioAssets/bgm/intro_track_bgm.ogg")
@onready var game_music := preload("res://audioAssets/bgm/triangulate_bgm.ogg")
@onready var boss_music := preload("res://audioAssets/bgm/boss_bgm.ogg")

@onready var audio_bus_layout := preload("res://audioPlayer/default_bus_layout.tres")

@onready var mission_compree_sfx := preload("res://audioAssets/MISSIONCOMPREE.ogg")
@onready var mission_start_sfx := preload("res://audioAssets/MISSIONSTART.ogg")
@onready var fuel_burning_2_sfx := preload("res://audioAssets/FUELBURNING2.ogg")
@onready var press_start_sfx := preload("res://audioAssets/PressStart.wav")
@onready var boss_warning_1_sfx := preload("res://audioAssets/bosswarning1.wav")
@onready var boss_warning_2_sfx := preload("res://audioAssets/evacuate.ogg")

func disable_lpf() -> void:
	($BGM as AudioStreamPlayer).bus = "BGM"
	
	
func enable_lpf() -> void:
	($BGM as AudioStreamPlayer).bus = "BGM_FX"

func cycle_channel() -> void:
	channel_id_to_play_on = (channel_id_to_play_on+1) % sfx_channels.size()

func get_next_channel() -> AudioStreamPlayer:
	cycle_channel()
	# 	print("current channel: %s" % channel_id_to_play_on)
	return sfx_channels[channel_id_to_play_on]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# print("audio player loaded")
	sfx_channels = [$SFX1, $SFX2, $SFX3, $SFX4, $SFX5, $SFX6, $SFX7, $SFX8]

func play_sfx(sfx_to_play: Variant, volume: float = 1.0) -> void:
	var channel: AudioStreamPlayer = get_next_channel()
	channel.stream = sfx_to_play
	var db := 10.0 * log(volume*sfx_volume/100.0)
	channel.volume_db = db
	channel.play()
	
func play_bgm(bgm_to_play: Variant, volume: float = 1.0) -> void:
	$BGM.stream = bgm_to_play
	if bgm_volume == 0.0:
		$BGM.volume_db = -80.0
	else:
		var db := 10.0 * log(volume*bgm_volume/100.0)
		$BGM.volume_db = db
	$BGM.play()
	
func stop_bgm() -> void:
	($BGM as AudioStreamPlayer).stop()

	
func set_sfx_volume() -> void:
	for sfx_channel in sfx_channels:
		(sfx_channel as AudioStreamPlayer).volume_db = 10.0 * log(sfx_volume/100.0)
	
func set_bgm_volume() -> void:
	($BGM as AudioStreamPlayer).volume_db = 10.0 * log(bgm_volume/100.0)
