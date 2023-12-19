extends Node2D

func _ready() -> void:
	AudioPlayer.play_sfx(AudioPlayer.boss_warning_1_sfx, 0.3)
	await get_tree().create_timer(0.5).timeout
	AudioPlayer.play_sfx(AudioPlayer.boss_warning_2_sfx, 0.9)
