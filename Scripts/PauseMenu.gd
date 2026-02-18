extends Control

@onready var pause_screen: ColorRect = $PauseScreen
@onready var pause_buttons: VBoxContainer = $PauseScreen/Buttons
@onready var confirm_exit: ColorRect = $ConfirmExit
@onready var exit_buttons: HBoxContainer = $ConfirmExit/Buttons

@onready var audio_controller: Node = $AudioController

var is_paused
var is_confirm: bool = false

func _ready():
	pause_screen.hide()
	confirm_exit.hide()

func _process(_delta: float) -> void:
	if !Global.is_game_over:
		if Input.is_action_just_pressed("ui_down") || Input.is_action_just_pressed("ui_up") || Input.is_action_just_pressed("ui_left") || Input.is_action_just_pressed("ui_right"):
			if pause_screen.visible == true || confirm_exit.visible == true:
				audio_controller.play_music(audio_controller.click_select_sfx)
		if Input.is_action_just_pressed("pause"):
			if !Global.is_controls_menu:
				if is_confirm == false:
					pause_unpause()
				else:
					_on_exit_no_pressed()
		
func pause_unpause():
	audio_controller.play_sfx(audio_controller.click_yes_sfx)
	is_paused = !get_tree().paused
	if is_paused:
		Global.is_pause_menu = true
		pause_screen.show()
		pause_buttons.find_child("Resume").grab_focus()
	else:
		Global.is_pause_menu = false
		pause_screen.hide()
	get_tree().paused = not get_tree().paused

func _on_resume_pressed() -> void:
	pause_unpause()

func _on_exit_pressed() -> void:
	audio_controller.play_sfx(audio_controller.click_yes_sfx)
	is_confirm = true
	pause_screen.hide()
	confirm_exit.show()
	exit_buttons.find_child("ExitNo").grab_focus()

func _on_exit_yes_pressed() -> void:
	audio_controller.play_sfx(audio_controller.click_yes_sfx)
	await get_tree().create_timer(0.5).timeout
	pause_unpause()
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

func _on_exit_no_pressed() -> void:
	audio_controller.play_sfx(audio_controller.click_yes_sfx)
	is_confirm = false
	pause_screen.show()
	confirm_exit.hide()
	pause_buttons.find_child("Resume").grab_focus()

func _on_controls_pressed() -> void:
	audio_controller.play_sfx(audio_controller.click_yes_sfx)
	is_confirm = true
	pause_screen.hide()

func _on_back_pressed() -> void:
	audio_controller.play_sfx(audio_controller.click_yes_sfx)
	is_confirm = false
	pause_screen.show()
	pause_buttons.find_child("Resume").grab_focus()
