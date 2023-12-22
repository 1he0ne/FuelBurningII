extends StaticBody2D

#A cannon that shoot a beam
#The beam extends until it hits a "is collider" (Glass is made as exception)
#Instant kills the player on beam hit. 
#Can be set to rotated (can also be attached to a Track) 

@export var rotation_speed := 2.0

var bright := false
var bright_counter := 0

var BRIGHT_COLOR := Color(1.0, 0.6, 0.3, 1.0)
var DARK_COLOR := Color(1.0, 0.5, 0.0, 1.0)

var is_destroyed := false
var turret_destroyed:Texture = load("res://sprites/Turrets/turret_laser_destroyed.png")

func _ready() -> void:
	$LauncherCollision/Turret.material.set_shader_param("width", 0)

func _physics_process(delta: float) -> void:
	delta *= $TimeSlowing.get_time_rate()

	$LauncherCollision.rotate(rotation_speed * delta)

	var cast_to := (Vector2.RIGHT * 1000.0).rotated($LauncherCollision.rotation)

	$RayCast2D.cast_to = cast_to

	if $RayCast2D.is_colliding():
		$BeamGraphic.points[1] = $BeamGraphic.to_local($RayCast2D.get_collision_point())
		$HitEffect.visible = true

		var hit_body : CollisionShape2D = $RayCast2D.get_collider()
		if hit_body.is_in_group("player"):
			hit_body.lose_health(1000)
		elif hit_body.is_in_group("LauncherCollision"):
			hit_body.set_destroyed()
			
	else:
		$BeamGraphic.points[1] = cast_to
		$HitEffect.visible = false

	$HitEffect.position = $BeamGraphic.points[1]
	$HitEffect.rotation = $LauncherCollision.rotation

	bright_counter += 1

	if bright_counter >= 8:
		bright = !bright
		bright_counter = 0

		if bright:
			$BeamGraphic.default_color = BRIGHT_COLOR
			$HitEffect.color = BRIGHT_COLOR
		else:
			$BeamGraphic.default_color = DARK_COLOR
			$HitEffect.color = DARK_COLOR
			
func set_destroyed() -> void:
	if is_destroyed:
		return
	$LauncherCollision/Turret.texture = turret_destroyed
	$BeamGraphic.visible = false
	$HitEffect.visible = false
	set_physics_process(false)
	$LauncherCollision/Turret.material.set_shader_param("width", 0)
	is_destroyed = true

func _process(delta: float) -> void:
	if delta != 0.0 and !is_destroyed:
		var delta2:float = delta * $TimeSlowing.get_time_rate()
		var percentage:float = 1 - (delta2/delta)
		#print("percentage = ", percentage)
		#print("linear2db = ", linear2db(percentage))
		# $Laser_hum.set_volume_db(linear2db(percentage))
		#if percentage > 0.01: #1 = 100%
		
		$LauncherCollision/Turret.material.set_shader_param("width", percentage * 3)
		#else:
		#	$LauncherCollision/Turret.material.set_shader_param("width", 0.0)

