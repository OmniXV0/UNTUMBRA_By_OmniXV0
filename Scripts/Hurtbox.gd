class_name Hurtbox extends Area2D

signal hurt(hitbox: Hitbox)

func _ready():
	area_entered.connect(_on_area_entered)

func _on_area_entered(area_2d: Area2D) -> void:
	if area_2d is not Hitbox:	#only detect other hitboxes even if hitboxes and hurtboxes are on the same collision layer
		return
	var hitbox = area_2d as Hitbox
	if self in hitbox.hit_targets:
		return
	if hitbox.stores_hit_targets:
		hitbox.hit_targets.append(self)
	hurt.emit(hitbox)
