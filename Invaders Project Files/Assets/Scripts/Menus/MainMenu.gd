extends Node2D

export (String, "Menus", "Levels") var SceneDir = "Menus"
export (String, "MainMenu", "GameOver") var Scene = "MainMenu"
export (String, "L1", "L2", "L3") var Level = "L1"

onready var HighscoreLabel = "MainMC/MainVB/ScoreHB/ScoreVB/HighscoreLabel"

func _ready():
	get_node(HighscoreLabel).text = str("Highscore : ", Globals.Highscore).pad_zeros(5)

func _process(_delta):
	if Input.is_action_just_pressed("Start_btn"):
		if SceneDir == "Menus":
			_ChangeScene(SceneDir, Scene)
		elif SceneDir == "Levels":
			_ChangeScene(SceneDir, Level)

func _ChangeScene(_d, _s):
# warning-ignore:return_value_discarded
	get_tree().change_scene_to(load(str("res://Assets/Scenes/", _d, "/", _s, ".tscn")))
