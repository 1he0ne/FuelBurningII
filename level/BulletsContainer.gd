extends Node

class_name BulletsContainer


func destroy_all_bullets():
	var all_children = get_children()
	for child in all_children:
		child.queue_free()
