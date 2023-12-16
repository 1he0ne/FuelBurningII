extends Area2D

## objective for player to shoot
##
##

@export var fadeout_time = 0.4
@export var max_health = 5.0
var health = max_health

func _ready():
	%ExplosionAnimation.visible = false
	
func _on_area_entered(area: Area2D) -> void:
	print("enemy hit")
	
	
	var bullet_that_hit: Bullet = area.get_parent() as Bullet
	var bullet_damage: float = bullet_that_hit.damage
	bullet_that_hit.queue_free()
	
	health = clampf(health - bullet_damage, 0.0, max_health) 
	
	if health > 0: # early exit
		return
	
	fade_out_and_delete(get_parent())
	
	%Guns.queue_free()
	
	%ExplosionAnimation.position = global_position
	%ExplosionAnimation.visible = true
	%ExplosionAnimation.play()

func fade_out_and_delete(node):
	var tween = create_tween()
	tween.set_process_mode(Tween.TWEEN_PROCESS_IDLE)
	tween.tween_property(node, "modulate" , Color(1, 1, 1, 0), fadeout_time)
	tween.tween_callback(node.queue_free)
	
