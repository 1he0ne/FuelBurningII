extends Node

var gun = null

func _ready():
	gun = $EnemyGun

	if randf() < 0.5:
		gun.init_spiral()
	else:
		gun.init_aimed_shot(12.0)

	gun.start(randf_range(0.5, 1.5))

func _process(delta):
	pass
