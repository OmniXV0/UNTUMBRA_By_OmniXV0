extends Node2D

@export var bullet_node: PackedScene
@onready var spawn_point: Marker2D = $SpawnPoint
@export var fire_delay: float = 0.25
@onready var fire_delay_timer: Timer = $FireDelayTimer

@onready var enemy_warrior = $".."

func _process(_delta: float) -> void:
	var look_vector = Vector2(0, 0)
	look_vector.x = enemy_warrior.direction.x + 0.225
	look_vector.y = enemy_warrior.direction.y + 0.225
	
	look_at(global_position + look_vector)
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
		z_index = -1
	else:
		scale.y = 1
		z_index = 1
	if !Global.is_game_over:
		if enemy_warrior.can_fire and fire_delay_timer.is_stopped():
			fire_delay_timer.start(fire_delay)
			var bullet = bullet_node.instantiate()
			get_tree().current_scene.add_child(bullet)
			bullet.global_position = spawn_point.global_position
			bullet.rotation = rotation
			bullet.hitbox_area.clear_hit_targets()
