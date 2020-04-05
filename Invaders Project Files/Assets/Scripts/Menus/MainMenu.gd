extends Node2D

export (String, "Menus", "Levels") var SceneDir = "Menus"
export (String, "MainMenu", "GameOver") var Scene = "MainMenu"
export (String, "L1", "L2", "L3") var Level = "L1"

var NextScene

onready var HighscoreLabel = "MainMC/MainVB/ScoreHB/ScoreVB/HighscoreLabel"

func _ready():
	if SceneDir == "Menus":
		NextScene = str("res://Assets/Scenes/", SceneDir, "/", Scene, ".tscn")
	elif SceneDir == "Levels":
		NextScene = str("res://Assets/Scenes/", SceneDir, "/", Level, ".tscn")
		
	get_node(HighscoreLabel).text = str("Highscore : ", Globals.Highscore).pad_zeros(5)

func _process(delta):
	if Input.is_action_just_pressed("Start_btn"):
		_ChangeScene()

func _ChangeScene():
	get_tree().change_scene_to(load(NextScene))
