extends Node2D

@onready var gun_sprite: Sprite2D = $GunSprite
@onready var big_blast: Sprite2D = $BigBlast
@onready var big_blast_hitbox_area: Hitbox = $BigBlast/HitboxArea
@onready var hitbox_collision: CollisionPolygon2D = $BigBlast/HitboxArea/HitboxCollision
@export var bullet_node: PackedScene
@onready var spawn_point: Marker2D = $SpawnPoint
@export var fire_delay: float = 0.25
@onready var fire_delay_timer: Timer = $FireDelayTimer
@onready var player_shoot_sfx: AudioStreamPlayer = $PlayerShootSFX
@export var bomb_node: PackedScene

@onready var player: Player = $".."
var can_fire: bool = false

var can_throw_bombs: bool = false

func _ready():
	gun_sprite.hide()
	big_blast.hide()
	player.stats.no_bombs.connect(no_bombs_throwing)

func _input(event):
	if event is InputEventMouseMotion:
		look_at(get_global_mouse_position())

func _process(delta: float) -> void:
	var look_vector = Vector2(0, 0)
	look_vector.x = Input.get_action_strength("aim_right") - Input.get_action_strength("aim_left")
	look_vector.y = Input.get_action_strength("aim_down") - Input.get_action_strength("aim_up")
	
	var rotation_speed = 10.0
	var rotation_velocity = Input.get_axis("aim_forwards", "aim_backwards") * rotation_speed
	rotate(rotation_velocity * delta)
	
	look_at(global_position + look_vector)
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
		z_index = -1
	else:
		scale.y = 1
		z_index = 1
	if Input.is_action_pressed("fire") and fire_delay_timer.is_stopped():
		gun_sprite.show()
		fire_delay_timer.start(fire_delay)
		if player.big_blast_powerup:
			can_fire = true
			hitbox_collision.disabled = false
			big_blast.show()
			big_blast_hitbox_area.clear_hit_targets()
		else:
			can_fire = false
			player_shoot_sfx.play()
			big_blast.hide()
			hitbox_collision.disabled = true
			var bullet = bullet_node.instantiate()
			get_tree().current_scene.add_child(bullet)
			bullet.global_position = spawn_point.global_position
			bullet.rotation = rotation
			bullet.hitbox_area.clear_hit_targets()
	elif !Input.is_action_pressed("fire"):
		can_fire = false
		gun_sprite.hide()
		big_blast.hide()
		hitbox_collision.disabled = true
	if can_fire:
		player.gun_animation.play("PlayerAnimation/BigBlastAnimation")
	else:
		player.gun_animation.stop()
		
	if Input.is_action_just_pressed("throw"):
		throw_bomb()
		
func throw_bomb():
	if player.stats.bombs > 0:
		can_throw_bombs = true
	if can_throw_bombs == true:
		print("BOMB")
		can_throw_bombs = false
		var bomb = bomb_node.instantiate()
		get_tree().current_scene.add_child(bomb)
		bomb.global_position = spawn_point.global_position
		bomb.rotation = rotation
		bomb.hitbox_area.clear_hit_targets()
		bomb.bomb_node_animation.play("BombAnimation/BombShockwaveAnimation")
		player.stats.bombs -= 1
		await get_tree().create_timer(0.5).timeout
		player.player_camera.screen_shake(5.0, 0.5)
		
func no_bombs_throwing():
	can_throw_bombs = false
	
func bomb_screen_shake(shake_amount, shake_time):
	player.player_bomb_sfx.play()
	player.player_camera.screen_shake(shake_amount, shake_time)
		
