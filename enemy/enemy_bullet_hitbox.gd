extends Area2D
## enemy area to take damage
##
## 


func _on_area_entered(area: Area2D) -> void:
	print("enemy hit")
	get_parent().queue_free()
