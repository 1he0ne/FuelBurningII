extends Node

var bomb_explosion_sfx = preload("res://audioAssets/bombdrop1.wav")
var bomb_not_available_sfx = preload("res://audioAssets/menuback1.wav")

func _input(event: InputEvent) -> void:
	if !event.is_action_pressed("fire_bomb"): return
	
	if GameState.use_bombs(1):
		var level_bullet_container:BulletsContainer = null
		level_bullet_container = get_tree().get_nodes_in_group("bullets_container")[0]
		if !level_bullet_container: print("invalid bullet container!")
		
		AudioPlayer.play_sfx(bomb_explosion_sfx)
		level_bullet_container.destroy_all_bullets()
	else:
		AudioPlayer.play_sfx(bomb_not_available_sfx)
