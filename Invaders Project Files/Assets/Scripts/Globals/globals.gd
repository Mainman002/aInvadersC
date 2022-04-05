extends Node

var Screen_Size = Vector2(
	ProjectSettings.get_setting("display/window/size/width"),
	ProjectSettings.get_setting("display/window/size/height")
)

var Highscore = 00000
var Score = 00000
var Aliens = 0

var Player_Alive = false

## KEYS / MOUSE
var player_control = "KEYS"

## NORMAL / PIERCE
var laser_mod = "NORMAL"

const Start_Lives = 3
onready var Lives = Start_Lives
