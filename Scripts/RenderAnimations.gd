extends AnimationPlayer

const LIBRARY_NAME := "PlayerAnimation"

const GODOT_PATH := "C:\\Program Files\\Godot 4.8\\Godot_v4.8-dev2_win64.exe"
const PROJECT_PATH := "C:\\Users\\OmniX\\OneDrive\\Documents\\Godot\\UNTUMBRA_By_OmniXV0"

const PLAYER_SCENE := "res://Scenes/Player.tscn"
const FPS := 60.0
const DURATION_MULTIPLIER := 2.0

func _ready():
	var arguments := OS.get_cmdline_user_args()

	for argument in arguments:
		if argument.begins_with("--render_animation="):
			var animation_name := argument.get_slice("=", 1)

			print("")
			print("==========================================")
			print("RENDERING ANIMATION")
			print("==========================================")
			print("Animation: ", animation_name)

			play_animation(animation_name)
			return

	# Normal scene run:
	# generate the batch file.
	generate_render_batch()

func play_animation(animation_name: String):
	var animation := get_animation(animation_name)

	if animation == null:
		push_error("Animation not found: " + animation_name)
		return

	print("Original length: ", animation.length)
	print("Render multiplier: ", DURATION_MULTIPLIER)
	print("Movie length: ", animation.length * DURATION_MULTIPLIER)

	play(animation_name)

func generate_render_batch():
	if not has_animation_library(LIBRARY_NAME):
		push_error("Animation library not found: " + LIBRARY_NAME)
		return

	var library := get_animation_library(LIBRARY_NAME)
	var animations := library.get_animation_list()

	var batch := "@echo off\r\n"
	batch += "setlocal\r\n"
	batch += "\r\n"

	batch += 'set GODOT="' + GODOT_PATH + '"\r\n'
	batch += 'set PROJECT="' + PROJECT_PATH + '"\r\n'
	batch += "\r\n"

	batch += 'if not exist "%PROJECT%\\Movies" mkdir "%PROJECT%\\Movies"\r\n'
	batch += "\r\n"

	batch += "echo ==========================================\r\n"
	batch += "echo UNTUMBRA Animation Renderer\r\n"
	batch += "echo Found " + str(animations.size()) + " animations\r\n"
	batch += "echo ==========================================\r\n"
	batch += "echo.\r\n"

	for animation_name in animations:
		var full_name := LIBRARY_NAME + "/" + animation_name
		var filename := full_name.replace("/", "-") + ".ogv"

		var animation := library.get_animation(animation_name)

		if animation == null:
			push_error("Could not find animation: " + animation_name)
			continue

		# Render for twice the animation's normal duration.
		var movie_duration := animation.length * DURATION_MULTIPLIER

		# Number of frames Godot should render.
		var frame_count := ceili(movie_duration * FPS)

		batch += "echo ==========================================\r\n"
		batch += "echo Rendering: " + full_name + "\r\n"
		batch += "echo Frames: " + str(frame_count) + "\r\n"
		batch += "echo ==========================================\r\n"

		batch += '%GODOT% --path %PROJECT% --scene "' + PLAYER_SCENE + '" --write-movie "%PROJECT%\\Movies\\' + filename + '" --fixed-fps 60 --quit-after ' + str(frame_count) + ' -- --render_animation="' + full_name + '"\r\n'

		batch += "if errorlevel 1 (\r\n"
		batch += "	echo ERROR rendering " + full_name + "\r\n"
		batch += "	pause\r\n"
		batch += "	exit /b 1\r\n"
		batch += ")\r\n"

		batch += "echo.\r\n"

	batch += "echo ==========================================\r\n"
	batch += "echo ALL ANIMATIONS FINISHED!\r\n"
	batch += "echo ==========================================\r\n"
	batch += "pause\r\n"

	var file := FileAccess.open("res://render_all.bat", FileAccess.WRITE)

	if file:
		file.store_string(batch)
		file.close()

		print("")
		print("==========================================")
		print("Generated render_all.bat")
		print("Animations found: ", animations.size())
		print("Player scene: ", PLAYER_SCENE)
		print("==========================================")
	else:
		push_error("Could not create render_all.bat")
