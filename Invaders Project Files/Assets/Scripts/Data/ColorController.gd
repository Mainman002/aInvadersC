extends Node

export (NodePath) var Sprite_Path = ".."
export (Array, Color) var Color_List = [Color(1,1,1,1),Color(1,0,0,1),
										Color(0,1,0,1),Color(0,1,1,1),
										Color(0,0,1,1),Color(1,1,0,1)]

func _ready():
	if has_node(Sprite_Path) and (Color_List.size() > 0):
		get_node(Sprite_Path).self_modulate = Color_List[int(Globals.Lives)]

