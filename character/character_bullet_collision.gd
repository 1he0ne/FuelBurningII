extends Area2D
## Player area to take damage
##
## 

@export var hit_flash_secs := 0.5
@export var hit_flash_color:Color = Color.LIGHT_SLATE_GRAY

@export var sidebar:SideBarCockpit

var lose_life_sfx: AudioStreamWAV = preload("res://audioAssets/explode1.wav")

var invul_frames: int = 0

func _physics_process(_delta: float) -> void:
	invul_frames = max(0, invul_frames - 1)

func _on_area_entered(area: Area2D) -> void:
	var bullet := area.get_parent() as Bullet
	if(bullet):
		do_bullet_hit_stuff()
		bullet.queue_free()
	print("player was hit by %s" % area.get_parent().name)

func _set_invul_frames_if_hit(num_frames: int) -> void:
	if invul_frames <= 0:
		invul_frames = num_frames

func do_bullet_hit_stuff() -> void:
	if invul_frames > 0: return
	
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