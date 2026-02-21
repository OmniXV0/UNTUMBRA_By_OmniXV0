extends Control

@export var player_stats: Stats

@onready var empty_hearts: TextureRect = $EmptyHearts
@onready var full_hearts: TextureRect = $FullHearts
@onready var empty_heals: TextureRect = $EmptyHeals
@onready var full_heals: TextureRect = $FullHeals
@onready var empty_bombs: TextureRect = $EmptyBombs
@onready var full_bombs: TextureRect = $FullBombs

func _ready() -> void:
	player_stats.health_changed.connect(set_full_hearts)
	player_stats.heals_changed.connect(set_full_heals)
	player_stats.bombs_changed.connect(set_full_bombs)
	
	set_empty_hearts(player_stats.max_health)
	set_full_hearts(player_stats.health)
	
	set_empty_heals(player_stats.max_heals)
	set_full_heals(player_stats.heals)
	
	set_empty_bombs(player_stats.max_bombs)
	set_full_bombs(player_stats.bombs)

func set_empty_hearts(value: int) -> void:
	empty_hearts.size.x = value * 30
func set_full_hearts(value: int) -> void:
	full_hearts.size.x = value * 30
	
func set_empty_heals(value: int) -> void:
	empty_heals.size.x = value * 15
func set_full_heals(value: int) -> void:
	full_heals.size.x = value * 15
	
func set_empty_bombs(value: int) -> void:
	empty_bombs.size.x = value * 15
func set_full_bombs(value: int) -> void:
	full_bombs.size.x = value * 15
