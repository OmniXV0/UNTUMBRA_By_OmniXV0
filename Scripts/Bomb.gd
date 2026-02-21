extends Node2D

@onready var bomb_node_animation: AnimationPlayer = $BombNodeAnimation

func set_property(tx_pos, tx_scale):
	position = tx_pos
	scale = tx_scale
