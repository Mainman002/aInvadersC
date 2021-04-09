extends Node

export (NodePath) var Sprite_Path = ".."
export (float) var Timer_Wait = 0.4
export (String, "Player", "Enemy", "Laser") var Death_Type
export (Array, Texture) var Sprite_List
export (Array, Texture) var Explosion_List

var current_frame = 0
var alive = true


func _ready():
#	needed to randomize values before level loads
	randomize()
	
#	Randomize start image to make characters look more interesting
	current_frame = round(rand_range(0, Sprite_List.size()-1))
	
#	sets Timer node's wait_time so that the frame rate matches the variable
	$Timer.wait_time = Timer_Wait
	
# Connects a function to the Timer node
# warning-ignore:return_value_discarded
	$Timer.connect("timeout", self, "_timedOut")


func _timedOut():
	if alive:
		if Sprite_List.size() > 0:
			_animation_Update(Sprite_List)
	else:
		if Explosion_List.size() > 0:
			_animation_Update(Explosion_List)


func _animation_Update(_list):
	if current_frame < _list.size():
		current_frame += 1
	else:
		current_frame = 0
	
	if (_list.size() > 0):
		_change_Frame(_list[int(current_frame)-1])


func _dead():
	alive = false
	current_frame = 0
	$Timer.wait_time = .1


func _change_Frame(_sprite):
	if has_node(Sprite_Path):
		get_node(Sprite_Path).texture = _sprite
	
	if alive == false:
		if Death_Type == "Player":
			if current_frame > Explosion_List.size()-1:
				## get player spawner and spawn a new player
				get_node("../../Player_Spawner")._spawn()
				
				if Globals.Lives < 0:
					# warning-ignore:return_value_discarded
					get_tree().change_scene_to(load(str("res://Assets/Scenes/Menus/GameOver.tscn")))
				
				## remove player
				get_node("..").queue_free()
			
		elif Death_Type == "Enemy":
			if current_frame > Explosion_List.size()-1:
				## if this is the last enemy go to the GameOver menu
				if get_node("..").get_parent().get_child_count() < 2:
					# warning-ignore:return_value_discarded
					get_tree().change_scene_to(load(str("res://Assets/Scenes/Menus/GameOver.tscn")))
					
				Globals.Aliens -= 1
					
				get_node("..").queue_free()
		
		elif Death_Type == "Laser":
			if current_frame > Explosion_List.size()-1:
				get_node("..").queue_free()

