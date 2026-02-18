extends Node2D

@export var enemy_prefab: PackedScene
@export var enemy_warrior_prefab: PackedScene

var enemy: Node2D
var enemy_warrior: Node2D
var enemy_spawn_rate: int = 0
var enemies_dead: int = 0
var enemy_count: int = 0

@onready var enemy_bot_spawn_sfx: AudioStreamPlayer2D = $EnemyBotSpawnSFX
@onready var enemy_fighter_spawn_sfx: AudioStreamPlayer2D = $EnemyFighterSpawnSFX
@onready var enemy_slasher_spawn_sfx: AudioStreamPlayer2D = $EnemySlasherSpawnSFX
@onready var enemy_gunner_spawn_sfx: AudioStreamPlayer2D = $EnemyGunnerSpawnSFX

func _ready():
	await get_tree().create_timer(1).timeout
	spawn_enemy()

func _on_timer_timeout() -> void:
	enemy_count = self.get_child_count()
	if enemy_count <= 5:
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
	#elif enemy_spawn_rate == 9:
		#pass
	else:
		enemy_bot_spawn_sfx.play()
		enemy = enemy_prefab.instantiate()
		add_child(enemy)
