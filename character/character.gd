extends CharacterBody2D
## Player character to be controlled
##
## Moves in 8 directions


const SPEED = 300.0


func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Vector2(Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down") )
		
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
		
	var _collisions = move_and_slide()

#print("player knows they entered") #why player would want to know???
func _on_area_2d_area_entered(_area):
	pass
