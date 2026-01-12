extends Area2D

@onready var item_sprite: Sprite2D = $ItemSprite
@onready var item_collision: CollisionShape2D = $ItemCollision

var big_sword_item = load("res://Sprites/SwordItem.png")
var heals_item = load("res://Sprites/HealsItem.png")
var dash_item = load("res://Sprites/DashItem.png")
var big_gun_item = load("res://Sprites/GunItem.png")

var item_type: int = 0
var item_choice: int = 0

func _ready() -> void:
	item_type = randi_range(0, 3)	#CHANGE THIS BACK WHEN READY
	if item_type == 0:
		item_sprite.texture = big_sword_item
		item_choice = 0
	elif item_type == 1:
		item_sprite.texture = heals_item
		item_choice = 1
	elif item_type == 2:
		item_sprite.texture = dash_item
		item_choice = 2
	elif item_type == 3:
		item_sprite.texture = big_gun_item
		item_choice = 3
	await get_tree().create_timer(10).timeout
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		AudioController.play_sfx(AudioController.powerup_collect_sfx)
		if item_choice == 0:
			body.big_sword()
		if item_choice == 1:
			body.add_heal()
		if item_choice == 2:
			body.long_dash()
		if item_choice == 3:
			body.big_blast()
		queue_free()
