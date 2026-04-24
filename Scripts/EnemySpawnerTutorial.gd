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
@onready var timer: Timer = $Timer

@onready var tutorial_text: Control = $"../TutorialText"
@onready var tutorial_text_1: Label = $"../TutorialText/TutorialText1"
@onready var tutorial_text_2: Label = $"../TutorialText/TutorialText2"
@onready var tutorial_text_3: Label = $"../TutorialText/TutorialText3"

@onready var text_animation: AnimationPlayer = $"../TextAnimation"

func _ready():
	Global.lord_is_dead = true
	await get_tree().create_timer(1).timeout
	text_animation.play("TutorialTextAnimation/TutorialTextFadeIn")
	tutorial_text_1.text = "MOVE:
							ARROW KEYS
							or WASD KEYS
							or LEFT STICK/D-PAD"

func _on_timer_timeout() -> void:
	for i in get_children():
		if i is CharacterBody2D:
			if !i.is_dead:
				enemy_count += 1
			else:
				enemy_count -= 1
	if enemy_count < 5:
		if !Global.is_game_over:
			spawn_enemy()
	else:
		print("ENEMIES FULL")
	
func spawn_enemy():
	enemy_spawn_rate = randi_range(0, 9)
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
		if !Global.lord_is_dead:
			print("LORD ALREADY PRESENT")
			spawn_bot()
		else:
			print("LORD PRESENT")
			Global.lord_is_dead = false
			enemy_lord_spawn_sfx.play()
			enemy_lord = enemy_lord_prefab.instantiate()
			add_child(enemy_lord)
	else:
		spawn_bot()
		
func spawn_bot():
	enemy_bot_spawn_sfx.play()
	enemy = enemy_prefab.instantiate()
	add_child(enemy)
