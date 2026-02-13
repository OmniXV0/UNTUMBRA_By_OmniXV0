extends Node

var main_menu_music = load ("res://Audio/Music/OmniXV0 - Falling Up.mp3")
var game_music = load ("res://Audio/Music/OmniXV0 - World Without Words.mp3")
var game_music_part_0 = load ("res://Audio/Music/OmniXV0 - World Without Words - Part 0.mp3")
var game_music_part_1 = load ("res://Audio/Music/OmniXV0 - World Without Words - Part 1.mp3")
var game_music_part_2 = load ("res://Audio/Music/OmniXV0 - World Without Words - Part 2.mp3")
var game_music_part_3 = load ("res://Audio/Music/OmniXV0 - World Without Words - Part 3.mp3")

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

@onready var music_0: AudioStreamPlayer = $Music0
@onready var music_1: AudioStreamPlayer = $Music1
@onready var music_2: AudioStreamPlayer = $Music2
@onready var music_3: AudioStreamPlayer = $Music3

@onready var sfx: AudioStreamPlayer2D = $SFX

func play_music(stream_number, music_name):
	if stream_number == 0:
		music_0.stream = music_name
		music_0.play()
	if stream_number == 1:
		music_1.stream = music_name
		music_1.play()
	if stream_number == 2:
		music_2.stream = music_name
		music_2.play()
	if stream_number == 3:
		music_3.stream = music_name
		music_3.play()

func play_volume(stream_number: int, volume_number):
	if stream_number == 0:
		music_0.volume_db = volume_number
	if stream_number == 1:
		music_1.volume_db = volume_number
	if stream_number == 2:
		music_2.volume_db = volume_number
	if stream_number == 3:
		music_3.volume_db = volume_number
	
func stop_music():
	music_0.stop()
	
func play_sfx(sfx_name):
	sfx.stream = sfx_name
	sfx.play()
	
