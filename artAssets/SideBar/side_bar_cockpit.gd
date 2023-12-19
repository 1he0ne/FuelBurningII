extends Node2D

class_name SideBarCockpit

var frames_until_indifferent: int = 0

func show_character_damaged():
	$AnimatedSprite2D.set_frame_and_progress(2, 0.0)
	frames_until_indifferent = 20
	
func show_character_indifferent():
	$AnimatedSprite2D.set_frame_and_progress(1, 0.0)
	
func show_character_happy():
	$AnimatedSprite2D.set_frame_and_progress(3, 0.0)
	frames_until_indifferent = 30
	
func show_character_black():
	$AnimatedSprite2D.set_frame_and_progress(0, 0.0)
	frames_until_indifferent = 20
	

func _physics_process(_delta):
	frames_until_indifferent = max(frames_until_indifferent - 1, 0)
	if frames_until_indifferent == 0 :
		show_character_indifferent()
