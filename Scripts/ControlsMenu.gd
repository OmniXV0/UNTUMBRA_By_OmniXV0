extends Control

@onready var controls_screen: ColorRect = $ControlsScreen
@onready var audio_controller: Node = $AudioController

var is_controls

func _ready() -> void:
	controls_screen.hide()
	
func _process(_delta: float) -> void:
	if !Global.is_game_over:
		if Input.is_action_just_pressed("controls"):
			if !Global.is_pause_menu:
				audio_controller.play_sfx(audio_controller.click_yes_sfx)
				pause_unpause()
			
func pause_unpause():
	is_controls = !get_tree().paused
	if is_controls:
		Global.is_controls_menu = true
		controls_screen.show()
	else:
		Global.is_controls_menu = false
		controls_screen.hide()
	get_tree().paused = not get_tree().paused
