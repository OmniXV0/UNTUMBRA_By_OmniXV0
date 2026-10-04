@echo off
setlocal

set GODOT="C:\Program Files\Godot 4.8\Godot_v4.8-dev2_win64.exe"
set PROJECT="C:\Users\OmniX\OneDrive\Documents\Godot\UNTUMBRA_By_OmniXV0"

if not exist "%PROJECT%\Movies" mkdir "%PROJECT%\Movies"

echo ==========================================
echo UNTUMBRA Animation Renderer
echo Found 43 animations
echo ==========================================
echo.
echo ==========================================
echo Rendering: PlayerAnimation/BigBlastAnimation
echo Frames: 145
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-BigBlastAnimation.ogv" --fixed-fps 60 --quit-after 145 -- --render_animation="PlayerAnimation/BigBlastAnimation"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/BigBlastAnimation
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/BombsAdd
echo Frames: 60
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-BombsAdd.ogv" --fixed-fps 60 --quit-after 60 -- --render_animation="PlayerAnimation/BombsAdd"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/BombsAdd
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/DashDown
echo Frames: 25
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-DashDown.ogv" --fixed-fps 60 --quit-after 25 -- --render_animation="PlayerAnimation/DashDown"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/DashDown
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/DashLeft
echo Frames: 25
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-DashLeft.ogv" --fixed-fps 60 --quit-after 25 -- --render_animation="PlayerAnimation/DashLeft"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/DashLeft
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/DashRight
echo Frames: 25
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-DashRight.ogv" --fixed-fps 60 --quit-after 25 -- --render_animation="PlayerAnimation/DashRight"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/DashRight
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/DashUp
echo Frames: 25
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-DashUp.ogv" --fixed-fps 60 --quit-after 25 -- --render_animation="PlayerAnimation/DashUp"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/DashUp
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/GameOver
echo Frames: 180
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-GameOver.ogv" --fixed-fps 60 --quit-after 180 -- --render_animation="PlayerAnimation/GameOver"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/GameOver
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/HealsAdd
echo Frames: 60
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-HealsAdd.ogv" --fixed-fps 60 --quit-after 60 -- --render_animation="PlayerAnimation/HealsAdd"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/HealsAdd
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/HealsIconAnimation
echo Frames: 60
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-HealsIconAnimation.ogv" --fixed-fps 60 --quit-after 60 -- --render_animation="PlayerAnimation/HealsIconAnimation"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/HealsIconAnimation
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/HealsParticlesAnimation
echo Frames: 60
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-HealsParticlesAnimation.ogv" --fixed-fps 60 --quit-after 60 -- --render_animation="PlayerAnimation/HealsParticlesAnimation"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/HealsParticlesAnimation
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/IdleDown
echo Frames: 13
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-IdleDown.ogv" --fixed-fps 60 --quit-after 13 -- --render_animation="PlayerAnimation/IdleDown"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/IdleDown
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/IdleLeft
echo Frames: 13
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-IdleLeft.ogv" --fixed-fps 60 --quit-after 13 -- --render_animation="PlayerAnimation/IdleLeft"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/IdleLeft
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/IdleRight
echo Frames: 13
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-IdleRight.ogv" --fixed-fps 60 --quit-after 13 -- --render_animation="PlayerAnimation/IdleRight"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/IdleRight
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/IdleUp
echo Frames: 13
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-IdleUp.ogv" --fixed-fps 60 --quit-after 13 -- --render_animation="PlayerAnimation/IdleUp"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/IdleUp
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/InvincibilityFrames
echo Frames: 60
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-InvincibilityFrames.ogv" --fixed-fps 60 --quit-after 60 -- --render_animation="PlayerAnimation/InvincibilityFrames"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/InvincibilityFrames
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/SwingDashDown
echo Frames: 25
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-SwingDashDown.ogv" --fixed-fps 60 --quit-after 25 -- --render_animation="PlayerAnimation/SwingDashDown"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/SwingDashDown
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/SwingDashDown2
echo Frames: 25
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-SwingDashDown2.ogv" --fixed-fps 60 --quit-after 25 -- --render_animation="PlayerAnimation/SwingDashDown2"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/SwingDashDown2
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/SwingDashDown3
echo Frames: 25
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-SwingDashDown3.ogv" --fixed-fps 60 --quit-after 25 -- --render_animation="PlayerAnimation/SwingDashDown3"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/SwingDashDown3
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/SwingDashLeft
echo Frames: 25
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-SwingDashLeft.ogv" --fixed-fps 60 --quit-after 25 -- --render_animation="PlayerAnimation/SwingDashLeft"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/SwingDashLeft
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/SwingDashLeft2
echo Frames: 25
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-SwingDashLeft2.ogv" --fixed-fps 60 --quit-after 25 -- --render_animation="PlayerAnimation/SwingDashLeft2"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/SwingDashLeft2
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/SwingDashLeft3
echo Frames: 25
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-SwingDashLeft3.ogv" --fixed-fps 60 --quit-after 25 -- --render_animation="PlayerAnimation/SwingDashLeft3"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/SwingDashLeft3
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/SwingDashRight
echo Frames: 25
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-SwingDashRight.ogv" --fixed-fps 60 --quit-after 25 -- --render_animation="PlayerAnimation/SwingDashRight"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/SwingDashRight
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/SwingDashRight2
echo Frames: 25
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-SwingDashRight2.ogv" --fixed-fps 60 --quit-after 25 -- --render_animation="PlayerAnimation/SwingDashRight2"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/SwingDashRight2
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/SwingDashRight3
echo Frames: 25
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-SwingDashRight3.ogv" --fixed-fps 60 --quit-after 25 -- --render_animation="PlayerAnimation/SwingDashRight3"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/SwingDashRight3
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/SwingDashUp
echo Frames: 25
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-SwingDashUp.ogv" --fixed-fps 60 --quit-after 25 -- --render_animation="PlayerAnimation/SwingDashUp"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/SwingDashUp
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/SwingDashUp2
echo Frames: 25
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-SwingDashUp2.ogv" --fixed-fps 60 --quit-after 25 -- --render_animation="PlayerAnimation/SwingDashUp2"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/SwingDashUp2
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/SwingDashUp3
echo Frames: 25
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-SwingDashUp3.ogv" --fixed-fps 60 --quit-after 25 -- --render_animation="PlayerAnimation/SwingDashUp3"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/SwingDashUp3
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/SwingDown
echo Frames: 25
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-SwingDown.ogv" --fixed-fps 60 --quit-after 25 -- --render_animation="PlayerAnimation/SwingDown"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/SwingDown
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/SwingDown2
echo Frames: 25
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-SwingDown2.ogv" --fixed-fps 60 --quit-after 25 -- --render_animation="PlayerAnimation/SwingDown2"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/SwingDown2
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/SwingDown3
echo Frames: 25
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-SwingDown3.ogv" --fixed-fps 60 --quit-after 25 -- --render_animation="PlayerAnimation/SwingDown3"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/SwingDown3
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/SwingLeft
echo Frames: 25
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-SwingLeft.ogv" --fixed-fps 60 --quit-after 25 -- --render_animation="PlayerAnimation/SwingLeft"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/SwingLeft
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/SwingLeft2
echo Frames: 25
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-SwingLeft2.ogv" --fixed-fps 60 --quit-after 25 -- --render_animation="PlayerAnimation/SwingLeft2"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/SwingLeft2
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/SwingLeft3
echo Frames: 25
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-SwingLeft3.ogv" --fixed-fps 60 --quit-after 25 -- --render_animation="PlayerAnimation/SwingLeft3"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/SwingLeft3
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/SwingRight
echo Frames: 25
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-SwingRight.ogv" --fixed-fps 60 --quit-after 25 -- --render_animation="PlayerAnimation/SwingRight"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/SwingRight
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/SwingRight2
echo Frames: 25
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-SwingRight2.ogv" --fixed-fps 60 --quit-after 25 -- --render_animation="PlayerAnimation/SwingRight2"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/SwingRight2
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/SwingRight3
echo Frames: 25
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-SwingRight3.ogv" --fixed-fps 60 --quit-after 25 -- --render_animation="PlayerAnimation/SwingRight3"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/SwingRight3
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/SwingUp
echo Frames: 25
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-SwingUp.ogv" --fixed-fps 60 --quit-after 25 -- --render_animation="PlayerAnimation/SwingUp"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/SwingUp
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/SwingUp2
echo Frames: 25
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-SwingUp2.ogv" --fixed-fps 60 --quit-after 25 -- --render_animation="PlayerAnimation/SwingUp2"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/SwingUp2
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/SwingUp3
echo Frames: 25
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-SwingUp3.ogv" --fixed-fps 60 --quit-after 25 -- --render_animation="PlayerAnimation/SwingUp3"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/SwingUp3
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/WalkDown
echo Frames: 97
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-WalkDown.ogv" --fixed-fps 60 --quit-after 97 -- --render_animation="PlayerAnimation/WalkDown"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/WalkDown
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/WalkLeft
echo Frames: 97
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-WalkLeft.ogv" --fixed-fps 60 --quit-after 97 -- --render_animation="PlayerAnimation/WalkLeft"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/WalkLeft
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/WalkRight
echo Frames: 97
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-WalkRight.ogv" --fixed-fps 60 --quit-after 97 -- --render_animation="PlayerAnimation/WalkRight"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/WalkRight
	pause
	exit /b 1
)
echo.
echo ==========================================
echo Rendering: PlayerAnimation/WalkUp
echo Frames: 97
echo ==========================================
%GODOT% --path %PROJECT% --scene "res://Scenes/Player.tscn" --write-movie "%PROJECT%\Movies\PlayerAnimation-WalkUp.ogv" --fixed-fps 60 --quit-after 97 -- --render_animation="PlayerAnimation/WalkUp"
if errorlevel 1 (
	echo ERROR rendering PlayerAnimation/WalkUp
	pause
	exit /b 1
)
echo.
echo ==========================================
echo ALL ANIMATIONS FINISHED!
echo ==========================================
pause
