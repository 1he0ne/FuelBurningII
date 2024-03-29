extends CharacterBody2D
## Player character to be controlled
##
## Moves in 8 directions

const SPEED = 300.0

var character_world_position: float = 0.0

var camRef: Camera2D
var animRef: AnimatedSprite2D

# how far above camera 0 the camera follows the player
const upper_threshold = 600
# how far below camera 0 the player can't move back anymore
const lower_threshold = 1080

# how far the player may use left/right
const left_threshold = 70
const right_threshold = 580
const upper_limit = -13780

func _ready() -> void:
	camRef = %CharacterCamera
	animRef = $CharacterSprite
	
	#enabled the hitbox
	$ActivateEventsHitbox.visible = true

func _physics_process(_delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	var direction := Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down") )
		
	var cam_offset_position := camRef.position.y
	
	# update the camera, if the player moves up (but don't move it back down ever)
	if position.y < cam_offset_position+upper_threshold:
		camRef.position.y = position.y-upper_threshold
	
	velocity = direction * SPEED
	
	if direction.y > 0 && (position.y - cam_offset_position > lower_threshold):
		velocity.y = 0
		
	if direction.y < 0 && position.y <= upper_limit:
		velocity.y = 0
		
	if (direction.x < 0 && position.x < left_threshold) || (direction.x > 0 && position.x > right_threshold) : 
		velocity.x = 0
		
	# use frame based on x-velocity
	if velocity.x < 0:
		animRef.set_frame_and_progress(2, 0.0)
	elif velocity.x > 0:
		animRef.set_frame_and_progress(1, 0.0)
	else:
		animRef.set_frame_and_progress(0, 0.0)
	
	# print("Cam: %s | Player: %s" % [cam_offset_position, position.y])
		
	var _collisions := move_and_slide()

