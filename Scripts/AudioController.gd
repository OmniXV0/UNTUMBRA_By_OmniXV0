extends Node

var main_menu_music = load ("res://Audio/Music/OmniXV0 - OmniNihil (Loop) (Placeholder Music).mp3")
var game_music = load ("res://Audio/Music/OmniXV0 - Experiment -0 (Loop) (Placeholder).mp3")

var click_yes_sfx = load("res://Audio/SFX/ClickYesSFX.mp3")
var click_select_sfx = load("res://Audio/SFX/ClickSelectSFX.mp3")
var click_no_sfx = load("res://Audio/SFX/ClickNoSFX.mp3")

var enemy_take_damage_sfx = load("res://Audio/SFX/EnemyTakeDamageSFX.mp3")
var enemy_death_sfx = load("res://Audio/SFX/EnemyDeathSFX.mp3")
var enemy_fighter_attack_sfx = load("res://Audio/SFX/EnemyFighterAttackSFX.mp3")
var enemy_slasher_attack_sfx = load("res://Audio/SFX/EnemySlasherAttackSFX.mp3")
var enemy_gunner_attack_sfx = load("res://Audio/SFX/EnemyGunnerAttackSFX.mp3")

var powerup_spawn_sfx = load("res://Audio/SFX/PowerupSpawnSFX.mp3")
var powerup_collect_sfx = load("res://Audio/SFX/PowerupCollectSFX.mp3")

@onready var music = $Music
@onready var sfx = $SFX

func play_music(music_name):
	music.stream = music_name
	music.play()
	
func stop_music():
	music.stop()
	
func play_sfx(sfx_name):
	sfx.stream = sfx_name
	sfx.play()
	
