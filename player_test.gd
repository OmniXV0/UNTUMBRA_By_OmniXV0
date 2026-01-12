extends CharacterBody2D

@export var ghost_node: PackedScene
@onready var ghost_timer = $Timer

const speed: int = 100
var direction: Vector2 = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	velocity = direction * speed
	move_and_slide()
	
func add_ghost():
	var ghost = ghost_node.instantiate()
	ghost.set_property(position, $Sprite2D.scale)
	get_tree().current_scene.add_child(ghost)
	
func _on_timer_timeout() -> void:
	add_ghost()
