extends Area2D

## objective for player to shoot
##
##

@export var fadeout_time = 0.4
@export var max_health = 5.0
@export var hit_flash_time = 0.05
@export var fadeout_enabled := true

@onready var health = max_health
var is_alive := true

var hit_cue: AudioStreamWAV
var explode_cue: AudioStreamWAV

signal dying


func _ready():
	%ExplosionAnimation.visible = false
	
	hit_cue = preload("res://audioAssets/bullethit1.wav")
	explode_cue = preload("res://audioAssets/explode1.wav")

	
func _on_area_entered(area: Area2D) -> void:
	if !is_alive:
		return
		
	print("enemy hit")
	hit_cue.instantiate_playback()
		
	var bullet_that_hit: Bullet = area.get_parent() as Bullet
	
	# if bullet_that_hit: 
	###### do bullet stuff
	# var bomb_that_hit: BombArea = area.get_parent() as BombArea
	# if bomb_that_hit: 
	####### do bomb stuff
	
	var bullet_damage: float = bullet_that_hit.damage
	bullet_that_hit.queue_free()
	
	health = clampf(health - bullet_damage, 0.0, max_health)
	
	damage_flash_animation(get_parent())
	
	if health <= 0: 
		is_alive = false
		if fadeout_enabled:
			fade_out_and_delete(get_parent())
		
		#prevent more firing
		%Guns.queue_free() 
		
		%ExplosionAnimation.position = global_position
		%ExplosionAnimation.visible = true
		%ExplosionAnimation.play()
		
		AudioPlayer.play_sfx(explode_cue)
		
		dying.emit()
	else:
		AudioPlayer.play_sfx(hit_cue)


func fade_out_and_delete(enemy:Node2D):
	var tween = create_tween()
	tween.set_process_mode(Tween.TWEEN_PROCESS_IDLE)
	tween.tween_property(enemy, "modulate" , Color(1, 1, 1, 0), fadeout_time)
	tween.tween_callback(enemy.queue_free)
	

func damage_flash_animation(enemy:Node2D):
	var original_modulate = modulate
	
	var tween = create_tween()
	tween.set_process_mode(Tween.TWEEN_PROCESS_IDLE)
	tween.tween_property(enemy, "modulate" , Color.RED, hit_flash_time)
	tween.tween_property(enemy, "modulate" , original_modulate, hit_flash_time)

