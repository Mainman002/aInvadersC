extends Sprite

## check if enemy is alive
var alive = true
var temp_death_state = false

## set player laser speed
const SPEED = 80

func _ready():
# warning-ignore:return_value_discarded
	$Area2D.connect("area_entered", self, "_entered")

func _physics_process(delta):
	
	## remove player laser if it's out of screen view
	if global_position.y > Globals.Screen_Size.y+4:
		queue_free()
	
	if alive:
	
		## move laser up the screen
		global_position.y += SPEED * delta
		
	## if enemy is dead
	else:
		
		## move laser up the screen
		global_position.y += (SPEED * delta) / 2
		
		## hacky way to run a function without updating
		if temp_death_state:
			if has_node("Area2D"):
				$Area2D.queue_free()
			temp_death_state = false
			if has_node("AnimationController"):
				$AnimationController._dead()


func _entered(area):
	
	## check if laser collided with enemy
	if area.is_in_group("player"):
		
		## if health is greater then 1
		if area.get_parent().get("alive"):
			
			Globals.Lives -= 1
			
		## remove enemy (area2d was inside enemy sprite)
		area.get_parent().alive = false
		area.get_parent().temp_death_state = true
		
		Globals.Player_Alive = false
		
		## remove player laser
		queue_free()

