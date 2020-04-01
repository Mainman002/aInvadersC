extends Node2D

export (String, "Menus", "Levels") var SceneFolder = "Menus"
export (String, "MainMenu", "GameOver") var MenuSelection = "MainMenu"
export (String, "L1", "L2", "L3") var SceneSelection = "L1"

var nextScene

func _ready():
	if SceneFolder == "Menus":
		nextScene = str("res://Assets/Scenes/", SceneFolder, "/", MenuSelection, ".tscn")
	elif SceneFolder == "Levels":
		nextScene = str("res://Assets/Scenes/", SceneFolder, "/", SceneSelection, ".tscn")

func _process(_delta):
	if Input.is_action_just_pressed("Start_btn"):
		_changeScene()

func _changeScene():
	get_tree().change_scene_to(load(nextScene))
