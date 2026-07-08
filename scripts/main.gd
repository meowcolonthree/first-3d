extends Node

@onready var pause_menu = $PauseMenu
var paused = false

func _process(delta):
	if Input.is_action_just_pressed("mouse_capture_toggle"):
		pause()
		
func pause():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif not paused:
		pause_menu.show()
		Engine.time_scale = 0
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	paused = !paused
	
