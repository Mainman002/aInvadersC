extends Sprite

export(Array, Texture) var explosion_sprite_list

## check if enemy is alive
var alive = true
var temp_death_state = false

## animation
var current_sprite = 0
var current_fps = 0
var fps_delay = 5
var fps_rate = 0.1

## set player laser speed
const SPEED = 80

func _ready():
# warning-ignore:return_value_discarded
	$Area2D.connect("area_entered", self, "_entered")

func _physics_process(delta):
	
	## remove player laser if it's out of screen view
	if global_position.y < -8:
		queue_free()
	
	## if player laser is alive
	if alive:
	
		## move laser up the screen
		global_position.y -= SPEED * delta
	
	## if player laser is dead
	else:
		
		## move laser up the screen
		global_position.y -= (SPEED * delta) / 2
		
		## hacky way to run a function without updating
		if temp_death_state:
			## set current sprite to 0 for the explosion to play properly
			current_sprite = 0
			current_fps = 0
			fps_delay = 1
			fps_rate = 0.1
			if has_node("Area2D"):
				$Area2D.queue_free()
			temp_death_state = false
		
		## change the animation based on explosion sprite list
		_animate(explosion_sprite_list)

func _animate(_sprite):
	
	## if current fps is greater then 0
	if current_fps > 0:
		
		## countdown the current fps based on fps rate
		current_fps -= fps_rate
	else:
		
		## or reset the current fps to the fps delay
		current_fps = fps_delay
	
		## if the current sprite is less then sprite list
		if current_sprite < _sprite.size()-1:
			
			## increase the current sprite frame
			current_sprite += 1
		else:
			if alive:
				## or reset the current sprite frame
				current_sprite = 0
			else:
				
				## remove player laser
				queue_free()
	
		## check if sprite list is not empty
		if _sprite.size() != 0:
			
			## swap the texture to a sprite in the sprite list
			texture = _sprite[current_sprite]

func _entered(area):
	
	## check if laser collided with enemy
	if area.is_in_group("enemy"):
		
		## check if enemy has variable health
		if area.get_parent().get("health"):
			
			## if health is greater then 1
			if area.get_parent().health > 1:
				
				## subtract health by 1 point
				area.get_parent().health -= 1
				
			## if health is less then 1
			else:
				
				## set health to 0
				area.get_parent().health = 0
				
				## check if object has Score variable
				if area.get_parent().get("score"):
					
					## increase the Globals Score variable
					Globals.Score += area.get_parent().get("score")
				
				## remove enemy (area2d was inside enemy sprite)
				area.get_parent().alive = false
				area.get_parent().temp_death_state = true
				
				
		## check laser mode if we should remove on hit or not
		## Normal / Pierce
		if Globals.laser_mod == "NORMAL":
			
			## remove player laser
			queue_free()

