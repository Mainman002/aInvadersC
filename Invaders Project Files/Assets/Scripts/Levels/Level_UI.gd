extends MarginContainer

func _ready():
	
	## set default text to match our custom setup
	_update_label($UI_VB/Score_HB/HighScore, "HighScore", Globals.Highscore, 5)
	_update_label($UI_VB/Score_HB/Score, "Score", Globals.Score, 5)
	_update_label($UI_VB/Lives_HB/Lives, "Lives", Globals.Lives, 2)

func _process(_delta):
	
	## set our HighScore value if Score is greater then HighScore
	if Globals.Score > Globals.Highscore:
		Globals.Highscore = Globals.Score
		
		## update HighScore label's text
		_update_label($UI_VB/Score_HB/HighScore, "HighScore", Globals.Highscore, 5)
		
	## update other labels
	_update_label($UI_VB/Score_HB/Score, "Score", Globals.Score, 5)
	_update_label($UI_VB/Extras_HB/Aliens, "Aliens", Globals.Aliens, 3)
	
	if Globals.Lives >= 0:
		_update_label($UI_VB/Lives_HB/Lives, "Lives", Globals.Lives, 2)

func _update_label(_node, _name, _value, _padding):
	
	## check if the current _node's text isn't already set to this _value
	if _node.text != str(_name, " : ", _value).pad_zeros(_padding):
		
		## set labels text to this string
		_node.text = str(_name, " : ", _value).pad_zeros(_padding)
