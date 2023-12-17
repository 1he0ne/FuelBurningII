extends Node

class_name BulletsContainer

var bullet_scene: PackedScene = preload("res://weapons/autofire_gun/bullet/bullet.tscn")

func create_bullet(position, velocity):
	var bullet = bullet_scene.instantiate()
	bullet.position = position
	bullet.velocity = velocity
	bullet.rotation = velocity.rotated(deg_to_rad(90)).angle()
	add_child(bullet)

func destroy_all_bullets():
	var all_children = get_children()
	for child in all_children:
		child.queue_free()
