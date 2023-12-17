extends Node

var gun = null

func _ready():
	gun = $EnemyGun
	gun.init_aimed_alternating_spread()
	gun.start(randf_range(0.5, 1.5))

func _process(delta):
	pass
