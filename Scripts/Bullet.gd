extends Node2D
@onready var hitbox_area: Hitbox = $HitboxArea
@onready var bullet_sprite: Sprite2D = $BulletSprite
@onready var bullet_collision: CollisionShape2D = $HitboxArea/BulletCollision
@onready var bullet_screen_notifier: VisibleOnScreenNotifier2D = $BulletScreenNotifier

const SPEED: int = 500

func _process(delta: float) -> void:
	position += transform.x * SPEED * delta
	
func _on_bullet_screen_notifier_screen_exited() -> void:
	queue_free()
