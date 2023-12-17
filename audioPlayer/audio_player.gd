extends Node

var sfx_channels
var channel_id_to_play_on = 0

var sfx_volume = 80.0
var bgm_volume = 80.0

func cycle_channel():
	channel_id_to_play_on = (channel_id_to_play_on+1) % sfx_channels.size()

func get_next_channel() -> AudioStreamPlayer:
	cycle_channel()
	# 	print("current channel: %s" % channel_id_to_play_on)
	return sfx_channels[channel_id_to_play_on]

# Called when the node enters the scene tree for the first time.
func _ready():
	# print("audio player loaded")
	sfx_channels = [$SFX1, $SFX2, $SFX3, $SFX4, $SFX5, $SFX6, $SFX7, $SFX8]

func play_sfx(wav_to_play: AudioStreamWAV, volume: float = 1.0):
	var channel: AudioStreamPlayer = get_next_channel()
	channel.stream = wav_to_play
	var db = 10.0 * log(volume*sfx_volume/100.0)
	channel.volume_db = db
	channel.play()
	
func play_bgm(wav_to_play: AudioStreamWAV, volume: float = 1.0):
	$BGM.stream = wav_to_play
	var db = 10.0 * log(volume*bgm_volume/100.0)
	$BGM.play()
	
func set_sfx_volume():
	for sfx_channel in sfx_channels:
		(sfx_channel as AudioStreamPlayer).volume_db = 10.0 * log(sfx_volume/100.0)
	
func set_bgm_volume():
	($BGM as AudioStreamPlayer).volume_db = 10.0 * log(bgm_volume/100.0)

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
