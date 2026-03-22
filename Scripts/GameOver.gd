extends Control

@export var player_stats: Stats
@onready var game_over_screen: ColorRect = $GameOverScreen
@onready var game_over_buttons: VBoxContainer = $GameOverScreen/Buttons
@onready var confirm_continue: ColorRect = $ConfirmContinue
@onready var continue_buttons: HBoxContainer = $ConfirmContinue/Buttons
@onready var confirm_quit: ColorRect = $ConfirmQuit
@onready var quit_buttons: HBoxContainer = $ConfirmQuit/Buttons

@onready var audio_controller: Node = $AudioController

func _ready():
	confirm_continue.visible = false
	confirm_quit.visible = false
	
func _process(_delta: float) -> void:
	if Global.is_game_over == true:
		if Input.is_action_just_pressed("ui_down") || Input.is_action_just_pressed("ui_up") || Input.is_action_just_pressed("ui_left") || Input.is_action_just_pressed("ui_right"):
			if game_over_screen.visible == true || confirm_continue.visible == true || confirm_quit.visible == true:
				audio_controller.play_sfx(audio_controller.click_select_sfx)
		if Input.is_action_just_pressed("ui_cancel"):
			if confirm_continue.visible == true:
				_on_continue_no_pressed()
			elif confirm_quit.visible == true:
				_on_quit_no_pressed()
			elif self.visible == true && !confirm_continue.visible && !confirm_quit.visible:
				audio_controller.play_sfx(audio_controller.click_no_sfx)
	
func _on_continue_pressed() -> void:
	audio_controller.play_sfx(audio_controller.click_yes_sfx)
	game_over_screen.hide()
	confirm_continue.show()
	confirm_quit.hide()
	continue_buttons.find_child("ContinueNo").grab_focus()
	confirm_continue.show()
		
func _on_quit_pressed() -> void:
	audio_controller.play_sfx(audio_controller.click_yes_sfx)
	game_over_screen.hide()
	confirm_continue.hide()
	confirm_quit.show()
	quit_buttons.find_child("QuitNo").grab_focus()
	confirm_quit.show()

func _on_continue_yes_pressed() -> void:
	audio_controller.play_sfx(audio_controller.click_yes_sfx)
	player_stats.health = player_stats.max_health
	player_stats.heals = player_stats.max_heals
	player_stats.bombs = player_stats.max_bombs
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")

func _on_continue_no_pressed() -> void:
	audio_controller.play_sfx(audio_controller.click_yes_sfx)
	game_over_screen.show()
	confirm_continue.hide()
	game_over_buttons.find_child("Continue").grab_focus()

func _on_quit_yes_pressed() -> void:
	audio_controller.play_sfx(audio_controller.click_yes_sfx)
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

func _on_quit_no_pressed() -> void:
	audio_controller.play_sfx(audio_controller.click_yes_sfx)
	game_over_screen.show()
	confirm_quit.hide()
	game_over_buttons.find_child("Quit").grab_focus()
