extends Node2D

## Array for enemy scenes
export (Array, PackedScene) var barrier_list

func _ready():
	
	## Assign the tilemap node to a variable
	var tm = $Barrier_TileMap
	
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
		_spawn_barrier(tm, id.x, sizex, sizey, pos)
		
	## remove tilemap for node tree
	$Barrier_TileMap.queue_free()


## spawn an enemy
func _spawn_barrier(_tm, _id, _sizex, _sizey, _pos):
	
	## instance an enemy based on the enemy list
	var new_barrier = barrier_list[_id].instance()
	
	## set the new enemy position based on tilemap cell position
	new_barrier.global_position = Vector2(
		_pos.x * _sizex + (1 * _sizex),
		_pos.y * _sizey + (1 * _sizey)
	)
	
	## add a new enemy to the scene tree
	add_child(new_barrier)
	
	## clear the cell on the tilemap that was just used to spawn the enemy
	_tm.set_cell(_pos.x, _pos.y, -1)
