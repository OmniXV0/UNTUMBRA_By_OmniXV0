extends Node2D

@export var enemy_prefab: PackedScene
@export var enemy_warrior_prefab: PackedScene
@export var enemy_lord_prefab: PackedScene
@export var item_node_1: PackedScene
@export var item_node_2: PackedScene
@export var item_node_3: PackedScene

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

@onready var player: Player = $"../Player"
@onready var rock_wall: TileMapLayer = $"../RockWall"
@onready var rock_wall_collision: CollisionPolygon2D = $"../Boundary/RockWallCollision"
@onready var fade_screen_animation: AnimationPlayer = $"../UI/FadeScreen/FadeScreenAnimation"

enum States {
	MOVE_TEXT,
	MOVE,
	SLASH_TEXT,
	SLASH,
	DASH_TEXT,
	DASH,
	SHOOT_TEXT,
	SHOOT,
	UI_TEXT,
	UI,
	POWERUP_TEXT,
	POWERUP,
	COOLDOWN_TEXT,
	COOLDOWN,
	HEAL_TEXT,
	HEAL,
	THROW_TEXT,
	THROW,
	REPLENISH_TEXT,
	REPLENISH,
	BAR_TEXT,
	BAR,
	PAUSE_TEXT,
	PAUSE,
	CONTROLS_TEXT,
	CONTROLS,
	THANKS_TEXT,
	THANKS
}

var state = States.MOVE_TEXT

func change_state(new_state):
	state = new_state

func _ready():
	Global.is_tutorial = true
	Global.tutorial_enemy_number = 0
	Global.tutorial_heal = false
	Global.lord_is_dead = true
	
	rock_wall.hide()
	rock_wall_collision.disabled = true
	
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
				await get_tree().create_timer(1).timeout
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
				await get_tree().create_timer(1).timeout
				text_animation.play("TutorialTextAnimation/TutorialTextFadeOut")
				change_state(States.SHOOT_TEXT)
		States.SHOOT_TEXT:
			print("STATE: SHOOT_TEXT")
			text_animation.play("TutorialTextAnimation/TutorialTextFadeIn")
			tutorial_text_1.text = "SHOOT:
									C KEY (HOLD)
									MIDDLE MOUSE (HOLD)
									RIGHT TRIGGER (HOLD)"
			tutorial_text_2.text = "AIM (SHOOT/THROW BOMB):
									B or SHIFT KEYS (HOLD)
									DRAG MOUSE
									RIGHT STICK"
			spawn_enemy(0)
			player.position = Vector2(320, 320)
			change_state(States.SHOOT)
		States.SHOOT:
			print("STATE: SHOOT")
			rock_wall.show()
			rock_wall_collision.disabled = false
			if Global.tutorial_enemy_number == 2:
				await get_tree().create_timer(1).timeout
				text_animation.play("TutorialTextAnimation/TutorialTextFadeOut")
				change_state(States.UI_TEXT)
		States.UI_TEXT:
			print("STATE: UI_TEXT")
			rock_wall.hide()
			rock_wall_collision.disabled = true
			text_animation.play("TutorialTextAnimation/TutorialTextFadeIn")
			tutorial_text_1.text = "The score at the top right shows 
									total points from enemies 
									defeated"
			tutorial_text_2.text = "The time at the top center shows 
									how much time has passed"
			change_state(States.UI)
		States.UI:
			print("STATE: UI")
			if Input.is_action_just_pressed("down") || Input.is_action_just_pressed("up") || Input.is_action_just_pressed("left") || Input.is_action_just_pressed("right"):
				text_animation.play("TutorialTextAnimation/TutorialTextFadeOut")
				change_state(States.POWERUP_TEXT)
		States.POWERUP_TEXT:
			print("STATE: POWERUP_TEXT")
			text_animation.play("TutorialTextAnimation/TutorialTextFadeIn")
			tutorial_text_1.text = "Collect powerup items to upgrade 
									player abilities"
									
			var item = item_node_1.instantiate()
			item.position = Vector2(320, 125)
			item.item_type = 0
			get_tree().current_scene.add_child(item)
			
			var item_2 = item_node_2.instantiate()
			item_2.position = Vector2(220, 125)
			item_2.item_type = 1
			get_tree().current_scene.add_child(item_2)
			
			var item_3 = item_node_3.instantiate()
			item_3.position = Vector2(420, 125)
			item_3.item_type = 2
			get_tree().current_scene.add_child(item_3)
			change_state(States.POWERUP)
		States.POWERUP:
			print("STATE: POWERUP")
			if Global.tutorial_item_number == 3:
				await get_tree().create_timer(1).timeout
				text_animation.play("TutorialTextAnimation/TutorialTextFadeOut")
				change_state(States.COOLDOWN_TEXT)
		States.COOLDOWN_TEXT:
			print("STATE: COOLDOWN_TEXT")
			text_animation.play("TutorialTextAnimation/TutorialTextFadeIn")
			tutorial_text_1.text = "The cooldown bars show the time 
									left for each powerup"
			change_state(States.COOLDOWN)
		States.COOLDOWN:
			print("STATE: COOLDOWN")
			if Input.is_action_just_pressed("swing") || Input.is_action_just_pressed("dash") || Input.is_action_just_pressed("fire"):
				await get_tree().create_timer(1).timeout
				text_animation.play("TutorialTextAnimation/TutorialTextFadeOut")
				change_state(States.REPLENISH_TEXT)
		States.REPLENISH_TEXT:
			print("STATE: REPLENISH_TEXT")
			text_animation.play("TutorialTextAnimation/TutorialTextFadeIn")
			tutorial_text_1.text = "Collect replenish items to restore 
									lost bar abilities"
									
			var item = item_node_1.instantiate()
			item.position = Vector2(220, 125)
			item.item_type = 3
			get_tree().current_scene.add_child(item)
			
			var item_2 = item_node_2.instantiate()
			item_2.position = Vector2(420, 125)
			item_2.item_type = 4
			get_tree().current_scene.add_child(item_2)
			change_state(States.REPLENISH)
		States.REPLENISH:
			print("STATE: REPLENISH")
			if Global.tutorial_item_number == 5:
				await get_tree().create_timer(1).timeout
				text_animation.play("TutorialTextAnimation/TutorialTextFadeOut")
				change_state(States.BAR_TEXT)
		States.BAR_TEXT:
			print("STATE: BAR_TEXT")
			text_animation.play("TutorialTextAnimation/TutorialTextFadeIn")
			tutorial_text_1.text = "The health bar shows how many 
									more times you can get hit"
			tutorial_text_2.text = "the heals bar shows how many 
									many heals you have"
			change_state(States.BAR)
		States.BAR:
			print("STATE: BAR")
			if Global.tutorial_heal == true || Input.is_action_just_pressed("throw"):
				await get_tree().create_timer(1).timeout
				text_animation.play("TutorialTextAnimation/TutorialTextFadeOut")
				change_state(States.PAUSE_TEXT)
		States.PAUSE_TEXT:
			print("STATE: PAUSE_TEXT")
			tutorial_text_1.text = "PAUSE MENU:
									ESCAPE
									START BUTTON"
			change_state(States.PAUSE)
		States.PAUSE:
			print("STATE: PAUSE")
			if Input.is_action_just_pressed("pause"):
				await get_tree().create_timer(1).timeout
				text_animation.play("TutorialTextAnimation/TutorialTextFadeOut")
				change_state(States.CONTROLS_TEXT)
		States.CONTROLS_TEXT:
			print("STATE: CONTROLS_TEXT")
			tutorial_text_1.text = "CONTROLS MENU:
									TAB
									SELECT BUTTON"
			change_state(States.CONTROLS)
		States.CONTROLS:
			print("STATE: CONTROLS")
			if Input.is_action_just_pressed("controls"):
				await get_tree().create_timer(1).timeout
				text_animation.play("TutorialTextAnimation/TutorialTextFadeOut")
				change_state(States.THANKS_TEXT)
		States.THANKS_TEXT:
			print("STATE: THANKS_TEXT")
			tutorial_text_1.text = "Thanks for playing
									the tutorial!"
			change_state(States.THANKS)
		States.THANKS:
			print("STATE: THANKS")
			if Input.is_action_just_pressed("down") || Input.is_action_just_pressed("up") || Input.is_action_just_pressed("left") || Input.is_action_just_pressed("right"):
				text_animation.play("TutorialTextAnimation/TutorialTextFadeOut")
				fade_screen_animation.play("FadeScreen")
			
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
		
func _on_fade_screen_animation_animation_finished(_anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
