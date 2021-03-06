extends Sprite

## set player laser speed
const SPEED = 80

func _ready():
# warning-ignore:return_value_discarded
	$Area2D.connect("area_entered", self, "_entered")

func _physics_process(delta):
	
	## move laser up the screen
	global_position.y -= SPEED * delta
	
	## remove player laser if it's out of screen view
	if global_position.y < -8:
		queue_free()

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

