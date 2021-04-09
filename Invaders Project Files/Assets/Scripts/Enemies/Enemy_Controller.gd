extends Node2D

## Array for enemy scenes
export (Array, PackedScene) var enemy_list

export (PackedScene) var laser

## Array for enemy shield colors
export (Array, Color) var shield_color_list

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

## shoot timers
var random_alien = 0
var shoot_reset = 4
var shoot_rate = 0.1
onready var shoot_delay = shoot_reset

## set the next down position
onready var next_pos = (global_position.y + v_distance)

## set the state
onready var state = MOVE_RIGHT

func _ready():
	
	randomize()
	
	## Assign the tilemap node to a variable
	var tm = $Enemy_TileMap
	
	## get the size of our tiles
	var sizex = tm.get_cell_size().x
	var sizey = tm.get_cell_size().y
	
	## check for used tilemap cells
	var uc = tm.get_used_cells()
	
	## check the positions and assign them to a pos variable
	for pos in uc:
		
		## assign id variable for numbers equal to the tilemap coords
		var id = tm.get_cell_autotile_coord(pos.x, pos.y)
		
		## spawn an enemy
		##      Tilemap, id (int),  size, position
		_spawn_enemy(tm, id.x, sizex, sizey, pos)
		
	## remove tilemap for node tree
	$Enemy_TileMap.queue_free()


## spawn an enemy
func _spawn_enemy(_tm, _id, _sizex, _sizey, _pos):
	
	## instance an enemy based on the enemy list
	var new_enemy = enemy_list[_id].instance()
	
	## set the new enemy position based on tilemap cell position
	new_enemy.global_position = Vector2(
		_pos.x * _sizex + (1 * _sizex),
		_pos.y * _sizey + (1 * _sizey)
	)
	
	## if the enemy has a health variable
	if new_enemy.get("health"):
		
		## assign the shield color list to the new enemy
		new_enemy.shield_list = shield_color_list
		
	## add a new enemy to the scene tree
	add_child(new_enemy)
	
	Globals.Aliens += 1
	
	## clear the cell on the tilemap that was just used to spawn the enemy
	_tm.set_cell(_pos.x, _pos.y, -1)

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
	
	## if player is alive
	if Globals.Player_Alive:
		if shoot_delay > 0:
			shoot_delay -= shoot_rate
		else:
			shoot_delay = shoot_reset
			
			for alien_id in get_children():
				if alien_id.alive:
					for alien in get_child_count():
						random_alien = round(rand_range(0, alien))
			_shoot_laser(random_alien)
	
	## if player is not alive
	else:
		shoot_delay = shoot_reset
		
		if get_child_count() > 0:
			for enemy_laser in get_node("../Enemy_Lasers").get_children():
				enemy_laser.alive = false
				enemy_laser.temp_death_state = true
				
		if get_node("../Lasers").get_child_count() > 0:
			for player_laser in get_node("../Lasers").get_children():
				player_laser.alive = false
				player_laser.temp_death_state = true


func _shoot_laser(_id):
	var new_laser = laser.instance()
	new_laser.global_position = get_child(_id).global_position
	get_node("../Enemy_Lasers").add_child(new_laser)

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
