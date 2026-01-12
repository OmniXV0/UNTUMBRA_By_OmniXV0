extends Node2D

@onready var gun_sprite: Sprite2D = $GunSprite
@onready var big_blast: Sprite2D = $BigBlast
@onready var big_blast_hitbox_area: Hitbox = $BigBlast/HitboxArea
@onready var hitbox_collision: CollisionPolygon2D = $BigBlast/HitboxArea/HitboxCollision
@export var bullet_node: PackedScene
@onready var spawn_point: Marker2D = $SpawnPoint
@export var fire_delay: float = 0.25
@onready var fire_delay_timer: Timer = $FireDelayTimer
@onready var player_shoot: AudioStreamPlayer = $PlayerShoot

@onready var player: Player = $".."
var can_fire: bool = false

func _ready():
	gun_sprite.hide()
	big_blast.hide()

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
			big_blast.show()
			big_blast_hitbox_area.clear_hit_targets()
		else:
			can_fire = false
			player_shoot.play()
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
		
