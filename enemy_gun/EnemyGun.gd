extends Node2D

var head := 0
var instructions := []
var aim_dir := Vector2(0,1)
var wait_timer:Timer = null
var bullets_container:Node = null
var player:CharacterBody2D = null

# Difficulty adjustment
var bullet_speed_scale := 1.0
var fire_rate_scale := 1.0

enum { WAIT, FIRE, AIM_AT_PLAYER, AIM_DOWN, TURN }

@export var can_fire := true

func _ready() -> void:
	wait_timer = $WaitTimer
	bullets_container = get_tree().get_nodes_in_group("bullets_container")[0]
	player = get_tree().get_nodes_in_group("player")[0]
	
	if !can_fire:
		var x := func() -> void: $WaitTimer.stop()
		x.call_deferred()
		

func init_aimed_shot(speed:float) -> void:
	instructions = [
		[ AIM_AT_PLAYER ],
		[ FIRE, { "speed": speed } ],
		[ WAIT, 0.5 ]
	]

func init_random_splat() -> void:
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

func init_aimed_alternating_spread() -> void:
	instructions = [
		[ AIM_AT_PLAYER ],
		[ FIRE, { "speed": 5.0, "angle": -10.0 }],
		[ FIRE, { "speed": 5.0 } ],
		[ FIRE, { "speed": 5.0, "angle": 10.0 }],
		[ WAIT, 0.2 ],
		[ AIM_AT_PLAYER ],
		[ FIRE, { "speed": 5.0, "angle": -5.0 }],
		[ FIRE, { "speed": 5.0, "angle": 5.0 }],
		[ WAIT, 1.5 ]
	]

func init_spiral() -> void:
	turn(randf_range(0.0, 360.0))
	instructions = [
		[ FIRE, { "speed": 4.0 }],
		[ TURN, 3.0 ],
		[ WAIT, 0.05 ],
		[ FIRE, { "speed": 4.0 }],
		[ TURN, 3.0 ],
		[ WAIT, 0.05 ],
		[ FIRE, { "speed": 4.0 }],
		[ TURN, 3.0 ],
		[ WAIT, 0.05 ],
		[ FIRE, { "speed": 4.0 }],
		[ TURN, 3.0 ],
		[ WAIT, 0.05 ],
		[ FIRE, { "speed": 4.0 }],
		[ TURN, 3.0 ],
		[ WAIT, 0.05 ],
		[ FIRE, { "speed": 4.0 }],
		[ TURN, 3.0 ],
		[ WAIT, 0.05 ],
		[ FIRE, { "speed": 4.0 }],
		[ TURN, 3.0 ],
		[ WAIT, 0.05 ],
		[ FIRE, { "speed": 4.0 }],
		[ TURN, 3.0 ],
		[ WAIT, 0.05 ],
		[ FIRE, { "speed": 4.0 }],
		[ TURN, 40.0 ],
		[ WAIT, 0.05 ]
	]

func init_spam() -> void:
	instructions = [
		[ FIRE, { "speed": [3.0, 10.0] } ],
		[ TURN, [10.0, 350.0] ],
		[ FIRE, { "speed": [3.0, 10.0] } ],
		[ TURN, [10.0, 350.0] ],
		[ FIRE, { "speed": [3.0, 10.0] } ],
		[ TURN, [10.0, 350.0] ],
		[ WAIT, 0.05 ]
	]

func init_turret_fire() -> void:
	instructions = [
		[ FIRE, { "speed": 7.0, "angle": -3.0 } ],
		[ FIRE, { "speed": 7.2 } ],
		[ FIRE, { "speed": 7.0, "angle": 3.0 } ],
		[ WAIT, 1.0 ]
	]

func init_double_lines() -> void:
	instructions = [
		[ AIM_AT_PLAYER ],
		[ FIRE, { "lateral_offset": -25.0 } ],
		[ FIRE, { "lateral_offset": 25.0 } ],
		[ WAIT, 0.05 ],
		[ FIRE, { "lateral_offset": -25.0 } ],
		[ FIRE, { "lateral_offset": 25.0 } ],
		[ WAIT, 0.05 ],
		[ FIRE, { "lateral_offset": -25.0 } ],
		[ FIRE, { "lateral_offset": 25.0 } ],
		[ WAIT, 0.05 ],
		[ FIRE, { "lateral_offset": -25.0 } ],
		[ FIRE, { "lateral_offset": 25.0 } ],
		[ WAIT, 1.5 ],
	]

func start(initial_delay := 0.0) -> void:
	if initial_delay == 0.0:
		execute()
	else:
		wait(initial_delay)

func stop() -> void:
	wait_timer.stop()

func execute() -> void:
	if instructions.is_empty():
		return

	while(true):
		var instr:Array = instructions[head]

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

func fire(params := {}) -> void:
	var normalized_aim_dir := aim_dir.normalized()

	var pos := global_position
	var vel := normalized_aim_dir
	var speed:Variant = params.get("speed", 5.0)
	var angle:Variant = params.get("angle", 0.0)
	var lateral_offset:Variant = params.get("lateral_offset", 0.0)

	if speed is Array:
		speed = randf_range(speed[0], speed[1])

	if angle is Array:
		angle = randf_range(angle[0], angle[1])

	if lateral_offset is Array:
		lateral_offset = randf_range(lateral_offset[0], lateral_offset[1])

	if lateral_offset != 0.0:
		var offset:Vector2 = normalized_aim_dir.rotated(deg_to_rad(90.0)) * lateral_offset
		pos += offset

	vel = vel.rotated(deg_to_rad(angle)) * speed * bullet_speed_scale

	bullets_container.create_bullet(pos, vel)

func wait(time:float) -> void:
	time *= (1.0 / fire_rate_scale)
	wait_timer.wait_time = time
	wait_timer.start()

func aim_at_player() -> void:
	aim_dir = (player.position - global_position).normalized()

func aim_down() -> void:
	aim_dir.x = 0
	aim_dir.y = 1

func turn(degrees:Variant) -> void:
	if degrees is Array:
		degrees = randf_range(degrees[0], degrees[1])

	aim_dir = aim_dir.rotated(deg_to_rad(degrees))

func _on_wait_timer_timeout() -> void:
	execute()
