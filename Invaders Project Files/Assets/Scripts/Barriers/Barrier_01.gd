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

func _process(_delta):
	
	## if barrier is dead
	if !alive:
		
		## hacky way to run a function without updating
		if temp_death_state:
			## set current sprite to 0 for the explosion to play properly
			current_sprite = 0
			current_fps = 0
			fps_delay = 1
			fps_rate = 0.1
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
				
				queue_free()
	
		## check if sprite list is not empty
		if _sprite.size() != 0:
			
			## swap the texture to a sprite in the sprite list
			texture = _sprite[current_sprite]


func _on_area_entered(area):
	if area.is_in_group("player_laser") or area.is_in_group("enemy_laser"):
		alive = false
		temp_death_state = true
		area.get_parent().queue_free()
