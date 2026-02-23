extends Node2D

@onready var bullet_screen_notifier: VisibleOnScreenNotifier2D = $BulletScreenNotifier
@onready var hitbox_area: Hitbox = $HitboxArea
const SPEED: int = 500

func _process(delta: float) -> void:
	position += transform.x * SPEED * delta
	
func _on_bullet_screen_notifier_screen_exited() -> void:
	queue_free()
