class_name Player extends CharacterBody2D

@export var stats: Stats
@export var player_frames: int
@export var dash_trail_node: PackedScene
@export var bomb_node: PackedScene

@onready var combo_timer: Timer = $ComboTimer
@onready var combo_timer_2: Timer = $ComboTimer2
@onready var dash_trail_timer: Timer = $DashTrailTimer
@onready var dash_trail_particles: GPUParticles2D = $DashTrailParticles
@onready var gun: Node2D = $Gun
@onready var gun_animation: AnimationPlayer = $GunAnimation
@onready var slash_timer: Timer = $SlashTimer
@onready var dash_timer: Timer = $DashTimer
@onready var blast_timer: Timer = $BlastTimer
@onready var enemy_bot_attack_sfx: AudioStreamPlayer = $EnemyBotAttackSFX

@onready var player_sprite: Sprite2D = $PlayerSprite
@onready var player_animation: AnimationPlayer = $PlayerAnimation
@onready var invincibility_frames_animation: AnimationPlayer = $InvincibilityFramesAnimation
@onready var player_animation_tree: AnimationTree = $PlayerAnimationTree
@onready var playback = player_animation_tree.get("parameters/PlayerStates/playback") as AnimationNodeStateMachinePlayback
@onready var player_camera: Camera2D = $PlayerCamera
@onready var player_collider: CollisionPolygon2D = $PlayerCollider
@onready var hitbox_area: Hitbox = $HitboxArea
@onready var hitbox_collision: CollisionPolygon2D = $HitboxArea/HitboxCollision
@onready var hurtbox_area: Hurtbox = $HurtboxArea
@onready var big_slash: Sprite2D = $BigSlash
@onready var heals_animation: AnimationPlayer = $HealsAnimation
@onready var bombs_animation: AnimationPlayer = $BombsAnimation

@onready var pause
@onready var game_over
@onready var cool_down_ui

@onready var player_attack_sfx: AudioStreamPlayer = $PlayerAttackSFX
@onready var player_big_slash_sfx: AudioStreamPlayer = $PlayerBigSlashSFX
@onready var player_dash_sfx: AudioStreamPlayer = $PlayerDashSFX
@onready var player_long_dash_sfx: AudioStreamPlayer = $PlayerLongDashSFX
@onready var player_take_damage_sfx: AudioStreamPlayer = $PlayerTakeDamageSFX
@onready var player_death_sfx: AudioStreamPlayer = $PlayerDeathSFX
@onready var player_heal_sfx: AudioStreamPlayer = $PlayerHealSFX

const speed: int = 100
const dash_speed: int = 700
const combo_move_speed: int = 1000
const friction = 300

var direction: Vector2 = Vector2.ZERO
var last_direction: = Vector2.DOWN
var swinging: bool = false
var swinging2: bool = false
var swinging3: bool = false

var dash_trail_frame: int = 0
var sound_has_played: bool = false
var can_heal: bool = false
var can_throw_bombs: bool = false
var bomb_speed: int = 100
var bomb_object: Node2D

var big_slash_powerup: bool = false
var speed_multiplier: int = 1
var long_dash_powerup: bool = false
var big_blast_powerup: bool = false

func _ready() -> void:
	Global.score = 0
	Global.is_game_over = false
	AudioController.play_music(0, AudioController.game_music_part_0)
	AudioController.play_music(1, AudioController.game_music_part_1)
	AudioController.play_music(2, AudioController.game_music_part_2)
	AudioController.play_music(3, AudioController.game_music_part_3)
	
	z_index = 0
	big_slash.hide()
	if get_tree().current_scene.name == "Game":
		pause = $"../UI/PauseMenu"
		game_over = $"../UI/GameOver/GameOverScreen"
		cool_down_ui = $"../UI/CoolDownUI"
		game_over.hide()
	hurtbox_area.hurt.connect(take_hit.call_deferred)
	stats.no_health.connect(player_death)
	stats.no_heals.connect(no_healing)
	stats.no_bombs.connect(no_bombs_throwing)
	
func _physics_process(delta: float) -> void:
	swinging = false
	swinging2 = false
	swinging3 = false
	var state = playback.get_current_node()
	match state:
		"Movement":
			dash_trail_timer.stop()
			dash_trail_particles.emitting = false
			direction = Input.get_vector("left", "right", "up", "down").normalized()
			if !Global.is_game_over:
				if direction != Vector2.ZERO:
					hitbox_area.knockback_direction = direction.normalized()
					last_direction = direction
					update_animation_parameters()
					
				if Input.is_action_just_pressed("swing"):
					swinging_sword()
					velocity = last_direction * combo_move_speed
					move_and_slide()
					
				if Input.is_action_just_pressed("dash"):
					if long_dash_powerup:
						player_long_dash_sfx.play()
					else:
						player_dash_sfx.play()
					playback.travel("DashState")
					dash_trail_timer.wait_time = 0.03
					dash_trail_timer.start()
					dash_trail_particles.emitting = true
					
				if Input.is_action_just_pressed("heal"):
					heal()
					
				if Input.is_action_just_pressed("throw"):
					throw_bomb()
					bomb_object.position += last_direction * bomb_speed
					move_and_slide()
					
				velocity = direction * speed
				move_and_slide()
				move_and_collide(velocity * delta)
			else:
				direction = Vector2.ZERO
		"DashState":
			big_slash.frame = 8
			if Input.is_action_just_pressed("swing"):
				swinging_sword()
			if Input.is_action_just_pressed("heal"):
				heal()
			velocity = last_direction * dash_speed * speed_multiplier
			move_and_slide()
			await get_tree().create_timer(1.0).timeout
			hitbox_collision.visible = false
			hitbox_collision.disabled = true
			
func swinging_sword():
	if big_slash_powerup:
		player_big_slash_sfx.play()
	else:
		player_attack_sfx.play()
	if combo_timer.is_stopped() && combo_timer_2.is_stopped():
		swinging = true
		swinging2 = false
		swinging3 = false
		combo_timer.wait_time = 0.5
		combo_timer.start()
		print("FIRST ATTACK")
	elif !combo_timer.is_stopped() && combo_timer_2.is_stopped():
		swinging = true
		swinging2 = true
		swinging3 = false
		combo_timer.stop()
		combo_timer_2.wait_time = 0.5
		combo_timer_2.start()
		print("SECOND ATTACK")
	elif combo_timer.is_stopped() && !combo_timer_2.is_stopped():
		swinging = true
		swinging2 = true
		swinging3 = true
		combo_timer_2.stop()
		print("THIRD ATTACK")
	hitbox_collision.visible = true
	hitbox_collision.disabled = false
	
func _on_dash_trail_timer_timeout() -> void:
	add_dash_trail()
	
func add_dash_trail():
	var dash_trail = dash_trail_node.instantiate()
	dash_trail.set_property(position, $PlayerSprite.scale)
	dash_trail.frame = player_sprite.frame
	get_tree().current_scene.add_child(dash_trail)
	if long_dash_powerup:
		dash_trail.modulate = Color.html("ffff00")
	else:
		dash_trail.modulate = Color.html("787878")
	
func big_sword():
	print("BIG SLASH")
	AudioController.play_volume(1, 0)
	big_slash_powerup = true
	big_slash.frame = 8
	hitbox_collision.scale = Vector2(2, 2)
	big_slash.show()
	slash_timer.start(10)
	cool_down_ui.slash_cool_down()
	
func long_dash():
	print("LONG DASH")
	AudioController.play_volume(2, 0)
	speed_multiplier = 3
	long_dash_powerup = true
	dash_timer.start(10)
	cool_down_ui.dash_cool_down()
	
func big_blast():
	print("BIG BLAST")
	AudioController.play_volume(3, 0)
	big_blast_powerup = true
	blast_timer.start(10)
	cool_down_ui.blast_cool_down()
	
func _on_slash_timer_timeout() -> void:
	AudioController.play_volume(1, -80)
	big_slash_powerup = false
	hitbox_collision.scale = Vector2(1, 1)
	big_slash.hide()
	
func _on_dash_timer_timeout() -> void:
	AudioController.play_volume(2, -80)
	long_dash_powerup = false
	speed_multiplier = 1
	
func _on_blast_timer_timeout() -> void:
	AudioController.play_volume(3, -80)
	big_blast_powerup = false
	gun_animation.stop()
	
func slash_screen_shake(shake_amount, shake_time):
	if big_slash_powerup:
		player_camera.screen_shake(shake_amount, shake_time)
		
func dash_screen_shake(shake_amount, shake_time):
	if long_dash_powerup:
		player_camera.screen_shake(shake_amount, shake_time)
		
func blast_screen_shake(shake_amount, shake_time):
	if big_blast_powerup:
		player_camera.screen_shake(shake_amount, shake_time)
		
func add_heal():
	print("ADD HEAL")
	heals_animation.play("PlayerAnimation/HealsAdd")
	if stats.heals < stats.max_heals:
		stats.heals += 1
	
func heal():
	if stats.health != stats.max_health:
		if stats.heals > 0:
			can_heal = true
		if can_heal == true:
			heals_animation.play("PlayerAnimation/HealsParticlesAnimation")
			await get_tree().create_timer(0.5).timeout
			if !Input.is_action_pressed("heal"):
				heals_animation.stop()
				print("RETURN")
				return
			if can_heal == true:
				can_heal = false
				player_heal_sfx.play()
				heals_animation.play("PlayerAnimation/HealsIconAnimation")
				stats.health = stats.max_health
				stats.heals -= 1
	
func no_healing():
	can_heal = false
	
func add_bomb():
	print("ADD BOMB")
	bombs_animation.play("PlayerAnimation/BombsAdd")
	if stats.bombs < stats.max_bombs:
		stats.bombs += 1
	
func throw_bomb():
	if stats.bombs > 0:
		can_throw_bombs = true
	if can_throw_bombs == true:
		print("BOMB")
		can_throw_bombs = false
		var bomb = bomb_node.instantiate()
		bomb.set_property(position, $PlayerSprite.scale)
		get_tree().current_scene.add_child(bomb)
		bomb_object = bomb
		stats.bombs -= 1
		bomb.bomb_node_animation.play("BombAnimation/BombShockwaveAnimation")
		await get_tree().create_timer(0.5).timeout
		player_camera.screen_shake(5.0, 0.5)
	
func no_bombs_throwing():
	can_throw_bombs = false
	
func player_death() -> void:
	z_index = 200
	AudioController.stop_music()
	if !sound_has_played:
		sound_has_played = true
		player_camera.screen_shake(10, 0.5)
		player_death_sfx.play()
	Global.is_game_over = true
	await get_tree().create_timer(1.5).timeout
	hide()
	remove_from_group("player")
	process_mode = Node.PROCESS_MODE_DISABLED
	game_over.show()
	game_over.find_child("Continue").grab_focus()
			
func take_hit(other_hitbox: Hitbox) -> void:
	if other_hitbox.enemy_collide_attack == true:
		enemy_bot_attack_sfx.play()
	player_camera.screen_shake(5, 0.5)
	if stats.health > 0:
		player_take_damage_sfx.play()
	stats.health -= other_hitbox.damage
	if !Global.is_game_over:
		invincibility_frames_animation.play("PlayerAnimation/InvincibilityFrames")
	else:
		invincibility_frames_animation.play("PlayerAnimation/GameOver")
		
func update_animation_parameters() -> void:
	player_animation_tree.set("parameters/PlayerStates/Movement/Walk/blend_position", direction)
	player_animation_tree.set("parameters/PlayerStates/Movement/Idle/blend_position", direction)
	player_animation_tree.set("parameters/PlayerStates/Movement/Swing/blend_position", direction)
	player_animation_tree.set("parameters/PlayerStates/Movement/Swing2/blend_position", direction)
	player_animation_tree.set("parameters/PlayerStates/Movement/Swing3/blend_position", direction)
	player_animation_tree.set("parameters/PlayerStates/DashState/Dash/blend_position", direction)
	player_animation_tree.set("parameters/PlayerStates/DashState/DashSwing/blend_position", direction)
	player_animation_tree.set("parameters/PlayerStates/DashState/DashSwing2/blend_position", direction)
	player_animation_tree.set("parameters/PlayerStates/DashState/DashSwing3/blend_position", direction)
