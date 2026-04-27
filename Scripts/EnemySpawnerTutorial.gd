extends Node2D

@export var enemy_prefab: PackedScene
@export var enemy_warrior_prefab: PackedScene
@export var enemy_lord_prefab: PackedScene

var enemy: Node2D
var enemy_warrior: Node2D
var enemy_lord: Node2D
var enemy_spawn_rate: int = 0
var enemies_dead: int = 0
var enemy_count: int = 0

@onready var enemy_bot_spawn_sfx: AudioStreamPlayer2D = $EnemyBotSpawnSFX
@onready var enemy_fighter_spawn_sfx: AudioStreamPlayer2D = $EnemyFighterSpawnSFX
@onready var enemy_slasher_spawn_sfx: AudioStreamPlayer2D = $EnemySlasherSpawnSFX
@onready var enemy_gunner_spawn_sfx: AudioStreamPlayer2D = $EnemyGunnerSpawnSFX
@onready var enemy_lord_spawn_sfx: AudioStreamPlayer2D = $EnemyLordSpawnSFX

@onready var tutorial_text: Control = $"../UI/TutorialText"
@onready var tutorial_text_1: Label = $"../UI/TutorialText/TutorialText1"
@onready var tutorial_text_2: Label = $"../UI/TutorialText/TutorialText2"
@onready var tutorial_text_3: Label = $"../UI/TutorialText/TutorialText3"

@onready var text_animation: AnimationPlayer = $"../TextAnimation"

enum States {
	MOVE_TEXT,
	MOVE,
	SLASH_TEXT,
	SLASH,
	DASH_TEXT,
	DASH,
	SHOOT_TEXT,
	SHOOT,
	UI,
	POWERUP,
	HEAL,
	THROW,
	REPLENISH,
	BAR,
	PAUSE,
	CONTROLS
}

var state = States.MOVE_TEXT

func change_state(new_state):
	state = new_state

func _ready():
	Global.is_tutorial = true
	Global.tutorial_enemy_number = 0
	Global.lord_is_dead = true
	
func _physics_process(_delta: float) -> void:
	match state:
		States.MOVE_TEXT:
			print("STATE: MOVE_TEXT")
			text_animation.play("TutorialTextAnimation/TutorialTextFadeIn")
			tutorial_text_1.text = "MOVE:
									ARROW KEYS
									or WASD KEYS
									or LEFT STICK/D-PAD"
			change_state(States.MOVE)
		States.MOVE:
			print("STATE: MOVE")
			if Input.is_action_just_pressed("down") || Input.is_action_just_pressed("up") || Input.is_action_just_pressed("left") || Input.is_action_just_pressed("right"):
				text_animation.play("TutorialTextAnimation/TutorialTextFadeOut")
				change_state(States.SLASH_TEXT)
		States.SLASH_TEXT:
			print("STATE: SLASH_TEXT")
			text_animation.play("TutorialTextAnimation/TutorialTextFadeIn")
			tutorial_text_1.text = "SLASH:
									Z KEY
									LEFT MOUSE
									A BUTTON
									
									Press 3 times fast for a combo"
			spawn_enemy(0)
			change_state(States.SLASH)
		States.SLASH:
			print("STATE: SLASH")
			if Global.tutorial_enemy_number == 1:
				text_animation.play("TutorialTextAnimation/TutorialTextFadeOut")
				change_state(States.DASH_TEXT)
		States.DASH_TEXT:
			print("STATE: DASH_TEXT")
			text_animation.play("TutorialTextAnimation/TutorialTextFadeIn")
			tutorial_text_1.text = "DASH:
									X KEY
									RIGHT MOUSE
									X BUTTON

									Dash through enemies to escape
									You can slash and dash at the same time"
			change_state(States.DASH)
		States.DASH:
			print("STATE: DASH")
			if Input.is_action_just_pressed("dash"):
				text_animation.play("TutorialTextAnimation/TutorialTextFadeOut")
				change_state(States.SHOOT_TEXT)
				
func spawn_enemy(spawn_id: int) -> void:
	print("SPAWN ENEMY")
	enemy_spawn_rate = spawn_id
	if enemy_spawn_rate == 6 || enemy_spawn_rate == 7 || enemy_spawn_rate == 8:
		enemy_warrior = enemy_warrior_prefab.instantiate()
		add_child(enemy_warrior)
		if enemy_spawn_rate == 6:
			enemy_warrior.enemy_id = 1
			enemy_fighter_spawn_sfx.play()
		elif enemy_spawn_rate == 7:
			enemy_warrior.enemy_id = 2
			enemy_slasher_spawn_sfx.play()
		elif enemy_spawn_rate == 8:
			enemy_warrior.enemy_id = 3
			enemy_gunner_spawn_sfx.play()
		else:
			pass
	elif enemy_spawn_rate == 9:
			enemy_lord_spawn_sfx.play()
			enemy_lord = enemy_lord_prefab.instantiate()
			add_child(enemy_lord)
	else:
		enemy_bot_spawn_sfx.play()
		enemy = enemy_prefab.instantiate()
		add_child(enemy)
