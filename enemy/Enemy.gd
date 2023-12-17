extends Node

var gun = null

func _ready():
	gun = $EnemyGun

	gun.init_aimed_shot(40.0)
	gun.start()
	return

	match randi_range(0, 3):
		0:
			gun.init_aimed_shot(12.0)
		1:
			gun.init_random_splat()
		2:
			gun.init_aimed_alternating_spread()
		3:
			gun.init_spiral()

	gun.start(randf_range(0.5, 1.5))

func _process(delta):
	pass
