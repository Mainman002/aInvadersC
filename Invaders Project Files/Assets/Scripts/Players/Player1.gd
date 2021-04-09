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

## check if enemy is alive
var alive = true
var temp_death_state = false

## speed of our player
const SPEED = 50

## amount of time it takes before you can shoot again
const SHOOT_DELAY = 4

## Set start state
onready var state = HOVER

## set the shoot cooldown variable when game starts
onready var shoot_cooldown = SHOOT_DELAY

## laser scene file
onready var laser_01 = preload("res://Assets/Instances/Lasers/Player_Lasers/Laser_01.tscn")

func _ready():
# warning-ignore:return_value_discarded
	$Area2D.connect("area_entered", self, "_colliding")
# warning-ignore:return_value_discarded
	$Area2D.connect("area_exited", self, "_not_colliding")

func _physics_process(delta):
	
	if alive:
	
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
	
		## if shoot cooldown is greater then 0 subtract by an amount
		if shoot_cooldown > 0:
			shoot_cooldown -= .1
		
		## if shoot cooldown is equal to 0 allow shooting laser
		else:
			
			## key input
			if Input.is_action_pressed("Shoot_btn"):
				
				## create an instance of out laser
				var new_laser = laser_01.instance()
				
				## add the laser to a parent node
				get_node("../Lasers").add_child(new_laser)
				
				## set the position of the new laser
				new_laser.global_position = Vector2(global_position.x, global_position.y-3)
				
				## reset the shoot cooldown amount
				shoot_cooldown = SHOOT_DELAY
	
	## if player is dead
	else:
		
		## hacky way to run a function without updating
		if temp_death_state:
			$Area2D.queue_free()
			temp_death_state = false
			if has_node("AnimationController"):
				$AnimationController._dead()


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
