extends Control

@onready var score: Label = $ScoreContainer/Score
	
func _process(_delta: float) -> void:
	score.text = str(Global.score)
	if Global.score > Global.high_score:
		Global.high_score = Global.score
		SaveLoad.contents_to_save.high_score = Global.high_score
		SaveLoad._save()
