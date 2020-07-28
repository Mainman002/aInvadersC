extends Node

## create a simple variable for the godot window size
var Screen_Size = Vector2(
	ProjectSettings.get_setting("display/window/size/width"),
	ProjectSettings.get_setting("display/window/size/height")
)

## set HighScore / Score
var Highscore = 00000
var Score = 00000

## variable holding alien count
var Aliens = 000

## check if player is alive
var Player_Alive = false

## KEYS / MOUSE
var player_control = "KEYS"

## NORMAL / PIERCE
var laser_mod = "NORMAL"

## set player lives
const Start_Lives = 3
onready var Lives = Start_Lives
