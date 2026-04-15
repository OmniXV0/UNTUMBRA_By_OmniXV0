extends Node

var is_game_over: bool = false
var is_pause_menu: bool = false
var is_controls_menu: bool = false

var lord_is_dead: bool = true

var score: int = 0
var high_score: int = 0
var time: int = 0
var time_score: int = 0

func format_time(seconds: int) -> String:
	var h = int(seconds / 3600.0)
	var m = int((seconds % 3600) / 60.0)
	var s = seconds % 60
	return '%02d:%02d:%02d' % [h, m, s]
