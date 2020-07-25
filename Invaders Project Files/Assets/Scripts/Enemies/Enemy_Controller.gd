extends Node2D

enum {
	MOVE_DOWN,
	MOVE_LEFT,
	MOVE_RIGHT
}

## movement
var h_speed = 18
var v_speed = 14
var v_distance = 4
var direction = "RIGHT"
var down_timer = 0

## set the next down position
onready var next_pos = (global_position.y + v_distance)

## set the state
onready var state = MOVE_RIGHT

func _process(delta):
	
	## checks the state
	match state:
		
		## check if state equals MOVE_RIGHT
		MOVE_RIGHT:
			global_position.x += h_speed * delta
		
		## check if state equals MOVE_LEFT
		MOVE_LEFT:
			global_position.x -= h_speed * delta
			
		## check if state equals MOVE_DOWN
		MOVE_DOWN:
			if down_timer > 0:
				down_timer -= .1
			else:
				
				## check if position is less then next positon
				if global_position.y < next_pos:
					
					## change state to MOVE_DOWN
					state = MOVE_DOWN
					
					## move the position down the screen
					global_position.y += v_speed * delta
				else:
					
					## set the next down position
					next_pos = (global_position.y + v_distance)
					
					## check if the enemy should move left or right after reaching the next position
					_move_down()

func _move_down():
	
	## if direction equals left
	if direction == "LEFT":
		
		## set state to MOVE_LEFT
		state = MOVE_LEFT
		
	## if direction equals right
	elif direction == "RIGHT":
		
		## set state to MOVE_RIGHT
		state = MOVE_RIGHT

func _set_state(_state):
	
	## a quick way to set the state from other nodes
	state = _state
