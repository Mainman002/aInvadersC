extends Sprite

## health
export (int) var health = 1

## score
export (int) var score = 1

## texture lists
export(Array, Texture) var character_sprite_list
export(Array, Texture) var explosion_sprite_list

enum {
	MOVE_DOWN,
	MOVE_LEFT,
	MOVE_RIGHT
}

var alive = true
var temp_death_state = false

## animation
var current_sprite = 0
var current_fps = 0
var fps_delay = 5
var fps_rate = 0.1

func _ready():
	## tell godot to randomize values
	randomize()
	
# warning-ignore:return_value_discarded
	$Area2D.connect("area_entered", self, "_colliding")
	
	## randomize the start texture
	current_sprite = round(rand_range(0, character_sprite_list.size()-1))

func _process(_delta):
	
	if alive:
	
		## change the animation based on character sprite list
		_animate(character_sprite_list)
		
	else:
		
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
				
				## if this is the last enemy go to the GameOver menu
				if get_parent().get_child_count() < 2:
# warning-ignore:return_value_discarded
					get_tree().change_scene_to(load(str("res://Assets/Scenes/Menus/GameOver.tscn")))
					
				queue_free()
	
		## check if sprite list is not empty
		if _sprite.size() != 0:
			
			## swap the texture to a sprite in the sprite list
			texture = _sprite[current_sprite]

func _colliding(area):
	
	## if colliding with the left border
	if area.is_in_group("left"):
		
		## change the parent state to MOVE_DOWN
		get_parent()._set_state(MOVE_DOWN)
		
		## change parent direction to right
		get_parent().direction = "RIGHT"
		
		## give the parent a slight delay after colliding
		get_parent().down_timer = 0.2
	
	## if colliding with the right border
	elif area.is_in_group("right"):
		
		## change the parent state to MOVE_DOWN
		get_parent()._set_state(MOVE_DOWN)
		
		## change parent direction to left
		get_parent().direction = "LEFT"
		
		## give the parent a slight delay after colliding
		get_parent().down_timer = 0.2
		
	elif area.is_in_group("bottom") or area.is_in_group("player"):
		## change to game over menu whent the enemy collides with the bottom border / player
		
# warning-ignore:return_value_discarded
		get_tree().change_scene_to(load(str("res://Assets/Scenes/Menus/GameOver.tscn")))

