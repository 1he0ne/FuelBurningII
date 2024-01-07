extends Area2D
## Player area to take damage
##
##


const MAX_DAMAGE_PARTICLE_EMITTERS = 5

@export var hit_flash_secs := 0.5
@export var hit_flash_color:Color = Color.LIGHT_SLATE_GRAY

@export var sidebar:SideBarCockpit

@export var damage_particles_scene:PackedScene

var lose_life_sfx: AudioStreamWAV = preload("res://audioAssets/explode1.wav")

var invul_frames: int = 0


func _ready() -> void:
	assert(damage_particles_scene, "need to set damage_particles_scene")


func _physics_process(_delta: float) -> void:
	invul_frames = max(0, invul_frames - 1)

func _on_area_entered(area: Area2D) -> void:
	var bullet := area.get_parent() as Bullet
	if(bullet):
		if invul_frames == 0:
			add_damage_particles(bullet.position)
			do_bullet_hit_stuff()
		bullet.queue_free()
	print("player was hit by %s" % area.get_parent().name)
	

func _set_invul_frames_if_hit(num_frames: int) -> void:
	if invul_frames <= 0:
		invul_frames = num_frames

func do_bullet_hit_stuff() -> void:
	_set_invul_frames_if_hit(GameState.seconds_to_frames(0.5))
	var is_alive := GameState.lose_extra_life()
	AudioPlayer.play_sfx(lose_life_sfx)
	print("Character lost an extra life (%s left) still alive = %s" % [GameState.num_extra_lives, is_alive])
	flash_animation(hit_flash_color, hit_flash_secs)
	(sidebar as SideBarCockpit).show_character_damaged()

func flash_animation(color: Color, flash_time: float) -> void:
	var tween := create_tween()
	tween.set_process_mode(Tween.TWEEN_PROCESS_IDLE)
	tween.tween_property(get_parent(), "modulate", color, flash_time/2.0)
	tween.tween_property(get_parent(), "modulate", Color(1,1,1,1), flash_time/2.0)
	

func add_damage_particles(bullet_position:Vector2) -> void:
	print("bullet_position: ", bullet_position)
	var _local_bullet_position := to_local(bullet_position)
	var damage_x := _local_bullet_position.x
	var smoke := damage_particles_scene.instantiate()
	smoke.position = Vector2(damage_x, 0)
	
	var damagesContainer := $"../DamagesContainer" as Node2D
	damagesContainer.add_child(smoke)
	
	if damagesContainer.get_child_count() > MAX_DAMAGE_PARTICLE_EMITTERS:
		var oldest:Node2D = damagesContainer.get_child(0)
		damagesContainer.remove_child(oldest)
		oldest.queue_free()
		
