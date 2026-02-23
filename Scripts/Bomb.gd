extends Node2D

@onready var bomb_node_animation: AnimationPlayer = $BombNodeAnimation
@onready var bomb_screen_notifier: VisibleOnScreenNotifier2D = $BombScreenNotifier
@onready var hitbox_area: Hitbox = $Hitbox

const SPEED: int = 200
var stop_bomb: bool = false
	
func _process(delta: float) -> void:
	if !stop_bomb:
		position += transform.x * SPEED * delta
	
func _on_bomb_screen_notifier_screen_exited() -> void:
	queue_free()
	
func bomb_screen_shake(shake_amount, shake_time):
	var player = get_node("../Player")
	stop_bomb = true
	player.player_bomb_sfx.play()
	player.player_camera.screen_shake(shake_amount, shake_time)
