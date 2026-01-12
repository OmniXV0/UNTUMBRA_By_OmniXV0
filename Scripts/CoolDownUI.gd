extends Control

@onready var player: Player = $"../../Player"
@onready var slash_bar: TextureProgressBar = $CoolDownContainer/BarContainer/SlashBar
@onready var dash_bar: TextureProgressBar = $CoolDownContainer/BarContainer2/DashBar
@onready var blast_bar: TextureProgressBar = $CoolDownContainer/BarContainer3/BlastBar
@onready var slash_wait_timer: Timer = $SlashWaitTimer
@onready var dash_wait_timer: Timer = $DashWaitTimer
@onready var blast_wait_timer: Timer = $BlastWaitTimer

func _ready() -> void:
	slash_bar.value = 0
	dash_bar.value = 0
	blast_bar.value = 0
	
func slash_cool_down():
	slash_bar.value = 10
	slash_wait_timer.start(1)
	return
	
func dash_cool_down():
	dash_bar.value = 10
	dash_wait_timer.start(1)
	return
	
func blast_cool_down():
	blast_bar.value = 10
	blast_wait_timer.start(1)
	return
	
func _on_slash_wait_timer_timeout() -> void:
	slash_bar.value -= 1
	if slash_bar.value <= 0:
		slash_wait_timer.stop()
		
func _on_dash_wait_timer_timeout() -> void:
	dash_bar.value -= 1
	if dash_bar.value <= 0:
		dash_wait_timer.stop()
		
func _on_blast_wait_timer_timeout() -> void:
	blast_bar.value -= 1
	if blast_bar.value <= 0:
		blast_wait_timer.stop()
