extends Sprite

## states to select later
enum {
	HOVER,
	MOVE_LEFT,
	MOVE_RIGHT,
	MOUSE_MOVE
	}

## move player to mouse if true
var wall_colliding = "NONE"

## speed of our player
const SPEED = 50

## Set start state
onready var state = HOVER

func _ready():
# warning-ignore:return_value_discarded
	$Area2D.connect("area_entered", self, "_colliding")
# warning-ignore:return_value_discarded
	$Area2D.connect("area_exited", self, "_not_colliding")

func _physics_process(delta):
	
	## Move with mouse cursor position
	if Globals.player_control == "MOUSE":
		
		## if player position equals mouse position
		if round(global_position.x) == round(get_global_mouse_position().x):
			state = HOVER
			
		## if player position doesn't equal mouse position
		else:
			## If player position is less then mouse position
			if round(global_position.x) < round(get_global_mouse_position().x):
				state = MOVE_RIGHT
				
			## If player position is greater then mouse position
			else:
				state = MOVE_LEFT
	
	## move with key inputs
	if Globals.player_control == "KEYS":
		
		## Move Left
		if Input.is_action_pressed("ui_left"):
			state = MOVE_LEFT
		
		## Move Right
		elif Input.is_action_pressed("ui_right"):
			state = MOVE_RIGHT
		
		## Release Left / Right Keys
		elif Input.is_action_just_released("ui_left") or Input.is_action_just_released("ui_right"):
			state = HOVER
	
	## Check states
	match state:

		## move left state
		MOVE_LEFT:
			if wall_colliding != "LEFT":
				position.x -= SPEED * delta
			
		## move right state
		MOVE_RIGHT:
			if wall_colliding != "RIGHT":
				position.x += SPEED * delta

## check for collisions
func _colliding(area):
	
	## entered left area bounds
	if area.is_in_group("left"):
		wall_colliding = "LEFT"
		
	## exited left area bounds
	elif area.is_in_group("right"):
		wall_colliding = "RIGHT"

## check for exited collisions
func _not_colliding(_area):
	
	## exited left and right area bounds
	wall_colliding = "NONE"
