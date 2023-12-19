extends Area2D
## Player area to take damage
##
## 

@export var hit_flash_time = 0.1
@export var hit_flash_color:Color = Color.LIGHT_SLATE_GRAY
@export var pickup_flash_time = 0.05

@export var sidebar:SideBarCockpit

var collect_pickup_sfx: AudioStreamWAV = preload("res://audioAssets/upgradecollected1.wav")
var lose_life_sfx: AudioStreamWAV = preload("res://audioAssets/explode1.wav")


func _on_area_entered(area: Area2D) -> void:
	
	var bullet = area.get_parent() as Bullet
	if(bullet):
		do_bullet_hit_stuff()
		bullet.queue_free()
		
		
	var bomb_pickup = area.get_parent() as BombPickup
	if(bomb_pickup):
		do_bomb_pickup_stuff()
		bomb_pickup.queue_free()
		
	var fuel_pickup = area.get_parent() as FuelPickup
	if(fuel_pickup):
		do_fuel_pickup_stuff()
		fuel_pickup.queue_free()
		
	print("player was hit by %s" % area.get_parent().name)

func do_bullet_hit_stuff():
	var is_alive = GameState.lose_extra_life()
	AudioPlayer.play_sfx(lose_life_sfx)
	print("Character lost an extra life (%s left) still alive = %s" % [GameState.num_extra_lives, is_alive])
	flash_animation(hit_flash_color, hit_flash_time)
	(sidebar as SideBarCockpit).show_character_damaged()
	
func do_bomb_pickup_stuff():
	GameState.add_bombs(1)
	AudioPlayer.play_sfx(collect_pickup_sfx)
	print("Character gained a bomb (%s total)" % GameState.num_bombs)
	flash_animation(Color.AQUAMARINE, pickup_flash_time)
	(sidebar as SideBarCockpit).show_character_happy()
	
func do_fuel_pickup_stuff():
	# are 10 secs good? should we make it configurable via the pickup?
	GameState.frames_left = mini(GameState.MAX_FRAMES, GameState.frames_left + GameState.seconds_to_frames(10))
	AudioPlayer.play_sfx(collect_pickup_sfx)
	print("Character gained some fuel")
	flash_animation(Color.AQUAMARINE, pickup_flash_time)
	(sidebar as SideBarCockpit).show_character_happy()


func flash_animation(color:Color, flash_time:float):
	var tween = create_tween()
	tween.set_process_mode(Tween.TWEEN_PROCESS_IDLE)
	tween.tween_property(get_parent(), "modulate", color, flash_time)
	tween.tween_property(get_parent(), "modulate", Color(1,1,1,1), flash_time)
