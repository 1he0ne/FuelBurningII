extends Area2D
## Player area to take damage
##
## 

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
	
	print("player was hit by %s" % area.get_parent().name)


func do_bullet_hit_stuff():
	var is_alive = GameState.lose_extra_life()
	AudioPlayer.play_sfx(lose_life_sfx)
	print("Character lost an extra life (%s left) still alive = %s" % [GameState.num_extra_lives, is_alive])
	
func do_bomb_pickup_stuff():
	GameState.add_bombs(1)
	AudioPlayer.play_sfx(collect_pickup_sfx)
	print("Character gained a bomb (%s total)" % GameState.num_bombs)
