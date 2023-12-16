extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	print("audio player loaded")
	pass # Replace with function body.

func play_sfx(wav_to_play: AudioStreamWAV):
	$SFX.stream = wav_to_play
	$SFX.play()
	
func play_bgm(wav_to_play: AudioStreamWAV):
	$BGM.stream = wav_to_play
	$BGM.play()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
