extends Node2D

export (String, "Menus", "Levels") var SceneDir = "Menus"
export (String, "MainMenu", "GameOver") var Scene = "MainMenu"
export (String, "L1", "L2", "L3") var Level = "L1"

onready var HighscoreLabel = "MainMC/MainVB/ScoreHB/ScoreVB/HighscoreLabel"
onready var ScoreLabel = "MainMC/MainVB/ScoreHB/ScoreVB/ScoreLabel"

func _ready():
	
	## check if the score is larger then highscore
	if Globals.Score > Globals.Highscore:
		
		## if yes then set highscore to the new score
		Globals.Highscore = Globals.Score
	
	## change the text to match highscore / score variables
	get_node(HighscoreLabel).text = str("Highscore : ", Globals.Highscore).pad_zeros(5)
	get_node(ScoreLabel).text = str("Score : ", Globals.Score).pad_zeros(5)

func _process(_delta):
	if Input.is_action_just_pressed("Start_btn"):
		
		## reset the score variable so that it doesn't keep increasing with each game over
		Globals.Score = 00000
		
		## reset player lives to default values
		Globals.Lives = Globals.Start_Lives
		
		## reset alien count to 0
		Globals.Aliens = 0
		
		if SceneDir == "Menus":
			_ChangeScene(SceneDir, Scene)
		elif SceneDir == "Levels":
			_ChangeScene(SceneDir, Level)

func _ChangeScene(_d, _s):
# warning-ignore:return_value_discarded
	get_tree().change_scene_to(load(str("res://Assets/Scenes/", _d, "/", _s, ".tscn")))
