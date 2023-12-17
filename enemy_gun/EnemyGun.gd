extends Node2D

var head = 0
var instructions = []
var aim_dir = Vector2(0,1)
var wait_timer = null
var bullets_container = null
var player = null

enum { WAIT, FIRE, AIM_AT_PLAYER, AIM_DOWN, TURN }

func _ready():
	wait_timer = $WaitTimer
	bullets_container = get_tree().get_nodes_in_group("bullets_container")[0]
	player = get_tree().get_nodes_in_group("player")[0]

func init_aimed_shot(speed):
	instructions = [
		[ AIM_AT_PLAYER ],
		[ FIRE, { "speed": speed, "angle": 0.0 } ],
		[ WAIT, 0.2 ]
	]

func init_random_splat():
	instructions = [
		[ AIM_AT_PLAYER ],
		[ FIRE, { "speed": [5.0, 5.5], "angle": [-6.0, 6.0] } ],
		[ FIRE, { "speed": [5.0, 5.5], "angle": [-6.0, 6.0] } ],
		[ FIRE, { "speed": [5.0, 5.5], "angle": [-6.0, 6.0] } ],
		[ WAIT, 0.1 ],
		[ FIRE, { "speed": [6.0, 6.5], "angle": [-6.0, 6.0] } ],
		[ FIRE, { "speed": [6.0, 6.5], "angle": [-6.0, 6.0] } ],
		[ FIRE, { "speed": [6.0, 6.5], "angle": [-6.0, 6.0] } ],
		[ WAIT, 0.1 ],
		[ FIRE, { "speed": [7.0, 7.5], "angle": [-6.0, 6.0] } ],
		[ FIRE, { "speed": [7.0, 7.5], "angle": [-6.0, 6.0] } ],
		[ FIRE, { "speed": [7.0, 7.5], "angle": [-6.0, 6.0] } ],
		[ WAIT, 2.0 ]
	]

func init_aimed_alternating_spread():
	instructions = [
		[ AIM_AT_PLAYER ],
		[ FIRE, { "speed": 5.0, "angle": -10.0 }],
		[ FIRE, { "speed": 5.0, "angle": null } ],
		[ FIRE, { "speed": 5.0, "angle": 10.0 }],
		[ WAIT, 0.2 ],
		[ AIM_AT_PLAYER ],
		[ FIRE, { "speed": 5.0, "angle": -5.0 }],
		[ FIRE, { "speed": 5.0, "angle": 5.0 }],
		[ WAIT, 1.5 ]
	]

func init_spiral():
	turn(randf_range(0.0, 360.0))
	instructions = [
		[ FIRE, { "speed": 4.0, "angle": 0.0 }],
		[ TURN, 3.0 ],
		[ WAIT, 0.05 ],
		[ FIRE, { "speed": 4.0, "angle": 0.0 }],
		[ TURN, 3.0 ],
		[ WAIT, 0.05 ],
		[ FIRE, { "speed": 4.0, "angle": 0.0 }],
		[ TURN, 3.0 ],
		[ WAIT, 0.05 ],
		[ FIRE, { "speed": 4.0, "angle": 0.0 }],
		[ TURN, 3.0 ],
		[ WAIT, 0.05 ],
		[ FIRE, { "speed": 4.0, "angle": 0.0 }],
		[ TURN, 3.0 ],
		[ WAIT, 0.05 ],
		[ FIRE, { "speed": 4.0, "angle": 0.0 }],
		[ TURN, 3.0 ],
		[ WAIT, 0.05 ],
		[ FIRE, { "speed": 4.0, "angle": 0.0 }],
		[ TURN, 3.0 ],
		[ WAIT, 0.05 ],
		[ FIRE, { "speed": 4.0, "angle": 0.0 }],
		[ TURN, 3.0 ],
		[ WAIT, 0.05 ],
		[ FIRE, { "speed": 4.0, "angle": 0.0 }],
		[ TURN, 40.0 ],
		[ WAIT, 0.05 ]
	]

func start(initial_delay = 0.0):
	if initial_delay == 0.0:
		execute()
	else:
		wait(initial_delay)

func execute():
	if instructions.is_empty():
		return

	while(true):
		var instr = instructions[head]

		head += 1
		if head >= instructions.size():
			head = 0

		match instr[0]:
			WAIT:
				wait(instr[1])
				return
			FIRE:
				fire(instr[1])
			AIM_AT_PLAYER:
				aim_at_player()
			AIM_DOWN:
				aim_down()
			TURN:
				turn(instr[1])

func fire(params):
	var vel = aim_dir.normalized()
	var speed = params["speed"]
	var angle = params["angle"]

	if speed is Array:
		speed = randf_range(speed[0], speed[1])

	if angle:
		if angle is Array:
			angle = randf_range(angle[0], angle[1])
		vel = vel.rotated(deg_to_rad(angle))

	vel = vel * speed

	bullets_container.create_bullet(global_position, vel)

func wait(time):
	wait_timer.wait_time = time
	wait_timer.start()

func aim_at_player():
	aim_dir = (player.position - global_position).normalized()
	pass

func aim_down():
	aim_dir.x = 0
	aim_dir.y = 1

func turn(degrees):
	aim_dir = aim_dir.rotated(deg_to_rad(degrees))

func _on_wait_timer_timeout():
	execute()
