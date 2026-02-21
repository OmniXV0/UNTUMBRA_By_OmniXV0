class_name Stats extends Resource

var free_enemy: bool = false

@export var max_health: = 1
@export var health: = max_health:
	set(value):
		var previous_health = health
		health = value
		if health != previous_health:
			health_changed.emit(health)
		if health <= 0: 
			no_health.emit()
@export var max_heals: = 1
@export var heals: = max_heals:
	set(value):
		var previous_heals = heals
		heals = value
		if heals != previous_heals:
			heals_changed.emit(heals)
		if heals <= 0: 
			no_heals.emit()
@export var max_bombs: = 1
@export var bombs: = max_bombs:
	set(value):
		var previous_bombs = bombs
		bombs = value
		if bombs != previous_bombs:
			bombs_changed.emit(bombs)
		if bombs <= 0: 
			no_bombs.emit()

signal health_changed(new_health)
signal no_health()
signal heals_changed(new_heals)
signal no_heals()
signal bombs_changed(new_bombs)
signal no_bombs()
