extends Position2D

export (PackedScene) var player

func _ready():
	_spawn()
	$Sprite.queue_free()

func _spawn():
	if player != null:
		var new_player = player.instance()
		new_player.global_position = global_position
		get_parent().call_deferred("add_child", new_player)
		Globals.Player_Alive = true
