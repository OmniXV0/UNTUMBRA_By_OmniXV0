extends Sprite2D

func _ready():
	trail()

func set_property(tx_pos, tx_scale):
	position = tx_pos
	scale = tx_scale

func trail():
	var tween_fade = get_tree().create_tween()
	tween_fade.tween_property(self, "self_modulate", Color(1, 1, 1, 0), 0.75)
	await tween_fade.finished
	queue_free()
