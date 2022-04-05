extends MarginContainer


func _ready():
	_update_label($UI_VB/Score_HB/HighScore, "HighScore", Globals.Highscore, 5)
	_update_label($UI_VB/Score_HB/Score, "Score", Globals.Score, 5)
	_update_label($UI_VB/Lives_HB/Lives, "Lives", Globals.Lives, 2)

func _process(delta):
	if Globals.Score > Globals.Highscore:
		Globals.Highscore = Globals.Score
		_update_label($UI_VB/Score_HB/HighScore, "HighScore", Globals.Highscore, 5)
	
	_update_label($UI_VB/Score_HB/Score, "Score", Globals.Score, 5)
	_update_label($UI_VB/Extras_HB/Aliens, "Aliens", Globals.Aliens, 3)
	_update_label($UI_VB/Lives_HB/Lives, "Lives", Globals.Lives, 2)

func _update_label(_node, _name, _value, _padding):
	if _node.text != str(_name, " : ", _value).pad_zeros(_padding):
		_node.text = str(_name, " : ", _value).pad_zeros(_padding)
