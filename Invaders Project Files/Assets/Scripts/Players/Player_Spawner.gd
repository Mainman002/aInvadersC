extends Position2D

## player scene to instance
export (PackedScene) var player

func _ready():
	
	## spawn a new player
	_spawn()
	
	## remove player preview sprite
	$Sprite.queue_free()

func _spawn():
	
	## if player scene doesn't exist then don't spawn player
	if player != null:
		
		## create new_player instance from player scene
		var new_player = player.instance()
		
		## set player position to spawner position
		new_player.global_position = global_position
		
		## spawn player in the main scene tree
		get_parent().call_deferred("add_child", new_player)
		
		## tell our Globals script that the player is alive
		Globals.Player_Alive = true
	else:
		
		## debug print to show us why the player isn't spawning
		print("Player scene not set")
