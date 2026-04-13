extends Control

@onready var timer_text: Label = $TimerText
@onready var timer: Timer = $Timer

var total_time_in_secs: int = 0

func _ready():
	timer.start()
	
func _process(_delta: float) -> void:
	timer_text.text = Global.format_time(Global.time)
	if total_time_in_secs > Global.time_score:
		Global.time_score = total_time_in_secs
		SaveLoad.contents_to_save.time_score = Global.time_score
		SaveLoad._save()

func _on_timer_timeout() -> void:
	if !Global.is_game_over:
		total_time_in_secs += 1
	Global.time = total_time_in_secs
	timer_text.text = Global.format_time(total_time_in_secs)
