extends Sprite

## health
export (int) var health = 1

## score
export (int) var score = 1

enum {
	MOVE_DOWN,
	MOVE_LEFT,
	MOVE_RIGHT
}

## shield color list
var shield_list = []

## check if enemy is alive
var alive = true
var temp_death_state = false

func _ready():
	
# warning-ignore:return_value_discarded
	$Area2D.connect("area_entered", self, "_colliding")
	
	## modulate the enemy color to match the health variable
	self_modulate = shield_list[health-1]

func _process(_delta):
	
	## if enemy is alive
	if alive:
		
		## check if the enemy isn't already the shield color
		if self_modulate != shield_list[health-1]:
			
			## modulate the enemy color to match the health variable
			self_modulate = shield_list[health-1]
		
	## if enemy is dead
	else:
		
		## hacky way to run a function without updating
		if temp_death_state:
			$Area2D.queue_free()
			temp_death_state = false
			if has_node("AnimationController"):
				$AnimationController._dead()



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

