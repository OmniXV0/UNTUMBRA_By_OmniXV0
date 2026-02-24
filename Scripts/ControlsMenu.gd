extends Control

@onready var controls_screen: ColorRect = $ControlsScreen
@onready var keyboard_without_mouse_screen: TextureRect = $ControlsScreen/KeyboardWithoutMouseScreen
@onready var keyboard_with_mouse_screen: TextureRect = $ControlsScreen/KeyboardWithMouseScreen
@onready var controller_screen: TextureRect = $ControlsScreen/ControllerScreen
@onready var audio_controller: Node = $AudioController

var is_controls

func _ready() -> void:
	controls_screen.hide()
	keyboard_without_mouse_screen.show()
	keyboard_with_mouse_screen.hide()
	controller_screen.hide()
	
func _process(_delta: float) -> void:
	if !Global.is_game_over:
		if Input.is_action_pressed("left") || Input.is_action_pressed("right"):
			audio_controller.play_sfx(audio_controller.click_select_sfx)
		if Input.is_action_just_pressed("controls"):
			if !Global.is_pause_menu:
				audio_controller.play_sfx(audio_controller.click_yes_sfx)
				pause_unpause()
		if keyboard_without_mouse_screen.visible == true:
			if Input.is_action_just_pressed("right"):
				keyboard_without_mouse_screen.hide()
				keyboard_with_mouse_screen.show()
				controller_screen.hide()
		elif keyboard_with_mouse_screen.visible == true:
			if Input.is_action_just_pressed("left"):
				keyboard_without_mouse_screen.show()
				keyboard_with_mouse_screen.hide()
				controller_screen.hide()
			if Input.is_action_just_pressed("right"):
				keyboard_without_mouse_screen.hide()
				keyboard_with_mouse_screen.hide()
				controller_screen.show()
		elif controller_screen.visible == true:
			if Input.is_action_just_pressed("left"):
				keyboard_without_mouse_screen.hide()
				keyboard_with_mouse_screen.show()
				controller_screen.hide()
			
func pause_unpause():
	is_controls = !get_tree().paused
	if is_controls:
		Global.is_controls_menu = true
		controls_screen.show()
	else:
		Global.is_controls_menu = false
		controls_screen.hide()
	get_tree().paused = not get_tree().paused
