extends Node

var sfx_channels
var channel_id_to_play_on = 0

func cycle_channel():
	channel_id_to_play_on = (channel_id_to_play_on+1) % sfx_channels.size()

func get_next_channel() -> AudioStreamPlayer:
	cycle_channel()
	print("current channel: %s" % channel_id_to_play_on)
	return sfx_channels[channel_id_to_play_on]

# Called when the node enters the scene tree for the first time.
func _ready():
	print("audio player loaded")
	sfx_channels = [$SFX1, $SFX2, $SFX3, $SFX4, $SFX5, $SFX6, $SFX7, $SFX8]

func play_sfx(wav_to_play: AudioStreamWAV):
	var channel: AudioStreamPlayer = get_next_channel()
	channel.stream = wav_to_play
	channel.play()
	
func play_bgm(wav_to_play: AudioStreamWAV):
	$BGM.stream = wav_to_play
	$BGM.play()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
