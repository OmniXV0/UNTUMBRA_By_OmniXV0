extends Control

@export var player_stats: Stats
@onready var main_menu_screen: TextureRect = $Background
@onready var confirm_exit: ColorRect = $ConfirmExit
@onready var main_menu_buttons: VBoxContainer = $Buttons
@onready var exit_buttons: HBoxContainer = $ConfirmExit/Buttons
@onready var high_score: Label = $HighScore

@onready var audio_controller: Node = $AudioController

func _ready():
	SaveLoad._load()
	Global.high_score = SaveLoad.contents_to_save.high_score
	high_score.text = str(Global.high_score)
	Global.is_game_over = false
	AudioController.play_music(0, AudioController.main_menu_music)
	main_menu_buttons.find_child("Play").grab_focus()
	main_menu_screen.show()
	confirm_exit.hide()
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_down") || Input.is_action_just_pressed("ui_up") || Input.is_action_just_pressed("ui_left") || Input.is_action_just_pressed("ui_right"):
		audio_controller.play_sfx(audio_controller.click_select_sfx)
	if Input.is_action_just_pressed("ui_cancel"):
		audio_controller.play_music(audio_controller.click_select_sfx)
		if confirm_exit.visible == true:
			_on_exit_no_pressed()
		else:
			_on_quit_pressed()

func _on_play_pressed() -> void:
	audio_controller.play_sfx(audio_controller.click_yes_sfx)
	player_stats.health = player_stats.max_health
	player_stats.heals = player_stats.max_heals
	Global.is_game_over = false
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")

func _on_quit_pressed() -> void:
	audio_controller.play_music(audio_controller.click_yes_sfx)
	main_menu_screen.hide()
	confirm_exit.show()
	exit_buttons.find_child("ExitNo").grab_focus()

func _on_exit_yes_pressed() -> void:
	audio_controller.play_sfx(audio_controller.click_yes_sfx)
	await get_tree().create_timer(0.5).timeout
	get_tree().quit()

func _on_exit_no_pressed() -> void:
	audio_controller.play_music(audio_controller.click_yes_sfx)
	main_menu_screen.show()
	confirm_exit.hide()
	main_menu_buttons.find_child("Quit").grab_focus()
