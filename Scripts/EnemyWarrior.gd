extends CharacterBody2D

const HIT_EFFECT = preload("res://Scenes/HitEffect.tscn")
const DEATH_EFFECT = preload("res://Scenes/DeathEffect.tscn")

@export var enemy_stats: Stats
@export var min_range: = 60
@export var max_range: = 1024
@export var enemy_id: int = 0
@export var enemy_fire_delay: float = 0.25
@export var item_node: PackedScene

@onready var enemy_sprite: Sprite2D = $EnemySprite
@onready var enemy_collision: CollisionShape2D = $EnemyCollision
@onready var enemy_animation: AnimationPlayer = $EnemyAnimation
@onready var enemy_animation_tree: AnimationTree = $EnemyAnimationTree
@onready var playback = enemy_animation_tree.get("parameters/EnemyWarriorState/playback") as AnimationNodeStateMachinePlayback
@onready var enemy_raycast: RayCast2D = $EnemyRaycast
@onready var enemy_dash_timer: Timer = $EnemyDashTimer
@onready var enemy_fire_timer: Timer = $EnemyShootTimer
@onready var enemy_gun: Node2D = $EnemyGun

@onready var hitbox_area: Hitbox = $HitboxArea
@onready var hurtbox_area: Hurtbox = $HurtboxArea
@onready var health_bar: ProgressBar = $HealthBar

@onready var center: Marker2D = $Center

@onready var enemy_hearts = $EnemyHeartsUI

const speed = 50
const friction = 500
var stop_enemy: bool = false
var direction: Vector2 = Vector2.ZERO
var can_dash: bool = false
var can_fire: bool = false
const dash_speed: int = 1000
const bullet_speed: int = 1000

func _ready() -> void:
	enemy_sprite.show()
	enemy_hearts.hide()
	enemy_stats = enemy_stats.duplicate()
	hurtbox_area.hurt.connect(take_hit.call_deferred)
	enemy_stats.no_health.connect(free_enemy)
	
func _physics_process(delta: float) -> void:
	if enemy_id == 1:
		enemy_sprite.texture = load("res://Sprites/Fighter.png")
	elif enemy_id == 2:
		enemy_sprite.texture = load("res://Sprites/Slasher.png")
	elif enemy_id == 3:
		enemy_sprite.texture = load("res://Sprites/Gunner.png")
	var state = playback.get_current_node()
	match state:
		"Idle": pass
		"Chase":
			can_fire = false
			var player_chased: = get_player()
			if player_chased is Player:
				if !Global.is_game_over:
					velocity = global_position.direction_to(player_chased.global_position) * speed	#move towards the player
					direction = global_position.direction_to(player_chased.global_position)
					if global_position.x != 320:	#"320" has to do with the screen size
						enemy_sprite.scale.x = sign(velocity.x)
				else:
					velocity = Vector2.ZERO
			else:
				velocity = Vector2.ZERO
			if stop_enemy == true:
				pass
				velocity = Vector2.ZERO
			move_and_slide()
		"Knockback":
			can_fire = false
			velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
			move_and_slide()
		"Attack":
			if enemy_id == 1:
				min_range = 60
				change_animation("EnemyWarriorAnimation/EnemyWarriorAttack")
			elif enemy_id == 2:
				min_range = 100
				change_animation("EnemyWarriorAnimation/EnemyWarriorDash")
				if can_dash:
					velocity = direction * dash_speed
					move_and_slide()
			elif enemy_id == 3:
				if !Global.is_game_over:
					var player_chased: = get_player()
					direction = global_position.direction_to(player_chased.global_position)
					if direction.x >= 0:
						enemy_gun.position.x = 35
						enemy_sprite.scale.x = 1
					elif direction.y < 0:
						enemy_gun.position.x = -35
						enemy_sprite.scale.x = -1
				min_range = 200
				change_animation("EnemyWarriorAnimation/EnemyWarriorShoot")
				
func enemy_warrior_attack():
	AudioController.play_sfx(AudioController.enemy_fighter_attack_sfx)
		
func enemy_warrior_dash():
	AudioController.play_sfx(AudioController.enemy_slasher_attack_sfx)
	can_dash = true
	enemy_dash_timer.start(0.3)
	
func enemy_warrior_shoot():
	AudioController.play_sfx(AudioController.enemy_gunner_attack_sfx)
	can_fire = true
	
func stop_shoot():
	can_fire = false
	
func change_animation(animation_name: String):
	enemy_animation_tree.get_tree_root().get_node("EnemyWarriorState").get_node("Attack").animation = animation_name
	
func get_player() -> Player:
	return get_tree().get_first_node_in_group("player")
	
func is_player_in_range() -> bool:
	var result = false
	var player_in_range: = get_player()
	if player_in_range is Player:
		var distance_to_player = global_position.distance_to(player_in_range.global_position)	#distance between player and enemy
		if distance_to_player < max_range and distance_to_player > min_range: 
			result = true
	return result
	
func is_player_in_attack() -> bool:
	if enemy_id == 1:
		min_range = 60
	elif enemy_id == 2:
		min_range = 100
	elif enemy_id == 3:
		min_range = 200
	var result = false
	var player_in_range: = get_player()
	if player_in_range is Player:
		var distance_to_player = global_position.distance_to(player_in_range.global_position)	#distance between player and enemy
		if distance_to_player <= min_range:
			result = true
	return result
	
func can_see_player() -> bool:	#to make the enemy not follow if player behind a wall, change the transitions in animation tree to "can_see_player()" and "not can_see_player()"
	if not is_player_in_range():
		return false
	var player_seen: = get_player()
	enemy_raycast.target_position = player_seen.global_position - global_position
	var is_line_of_sight_blocked: = not enemy_raycast.is_colliding()
	return is_line_of_sight_blocked
	
func take_hit(other_hitbox: Hitbox) -> void:
	var hit_effect = HIT_EFFECT.instantiate()
	get_tree().current_scene.add_child(hit_effect)
	hit_effect.global_position = center.global_position
	enemy_hearts.show()
	enemy_stats.health -= other_hitbox.damage
	enemy_hearts.set_full_hearts(enemy_stats.health)
	if enemy_stats.health != 0:
		AudioController.play_sfx(AudioController.enemy_take_damage_sfx)
	else:
		stop_enemy = true
		enemy_hearts.hide()
		enemy_collision.queue_free()
		if hitbox_area != null:
			hitbox_area.queue_free()
		if hurtbox_area != null:
			hurtbox_area.queue_free()
	if hitbox_area != null:
		velocity = other_hitbox.knockback_direction * 200
		playback.start("Knockback")
	
func free_enemy() -> void:
	if enemy_id == 0:
		Global.score += 10
	elif enemy_id == 1 || enemy_id == 2 || enemy_id == 3:
		Global.score += 100
	elif enemy_id == 4:
		Global.score += 1000
	else:
		pass
	var death_effect = DEATH_EFFECT.instantiate()
	get_tree().current_scene.add_child(death_effect)
	death_effect.global_position = global_position 
	if enemy_sprite.scale.x >= 0:
		print("FACING RIGHT")
		death_effect.flip_h = false
	elif enemy_sprite.scale.x < 0:
		print("FACING LEFT")
		death_effect.flip_h = true
	if enemy_id == 1:
		death_effect.play("FighterDeathEffect")
	elif enemy_id == 2:
		death_effect.play("SlasherDeathEffect")
	elif enemy_id == 3:
		death_effect.play("GunnerDeathEffect")
	
	var item_drop_rate: int = randi_range(0, 4)	#CHANGE THIS BACK WHEN READY
	if item_drop_rate == 0:
		enemy_sprite.hide()
		drop_item()
		despawn()
	else:
		print("No item")
		AudioController.play_sfx(AudioController.enemy_death_sfx)
		despawn()
		
func drop_item():
	print("Item")
	AudioController.play_sfx(AudioController.powerup_spawn_sfx)
	var item = item_node.instantiate()
	get_tree().current_scene.add_child(item)
	item.global_position = center.global_position
	
func despawn():
	stop_enemy = false
	queue_free()
	
func _on_enemy_dash_timer_timeout() -> void:
	can_dash = false
