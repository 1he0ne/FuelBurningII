extends Node

var gun: Node = null

signal is_dying

func _ready() -> void:
	gun = $EnemyGun

	# Difficulty adjustment example
	#gun.bullet_speed_scale = 2.0
	#gun.fire_rate_scale = 3.0

	match randi_range(0, 4):
		0:
			gun.init_aimed_shot(12.0)
		1:
			gun.init_random_splat()
		2:
			gun.init_aimed_alternating_spread()
		3:
			gun.init_spiral()
		4:
			gun.init_double_lines()

	#delay so they do not fire before being disabled (to be enabled later) 
	gun.start(0.1)

func _on_is_dying() -> void:
	if has_meta("is_boss") && get_meta("is_boss"):
		AudioPlayer.play_sfx(AudioPlayer.mission_compree_sfx)
