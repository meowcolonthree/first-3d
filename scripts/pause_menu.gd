extends Control

@onready var main = $"../"
@onready var settings: MarginContainer = $Settings
@onready var pause: MarginContainer = $Pause
var paused = false

func _ready():
	settings.hide()

func _on_resume_pressed() -> void:
	main.pause()

func _on_settings_pressed() -> void:
	settings.show()
	pause.hide()

func _input(event: InputEvent):
	if event.is_action_pressed("mouse_capture_toggle") and settings.visible:
		settings.hide()
		pause.show()
	elif event.is_action_pressed("mouse_capture_toggle") and not settings.visible:
		pass
		#pause_func()
		
func pause_func():
	if paused:
		pause.hide()
		Engine.time_scale = 1
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif not paused:
		pause.show()
		Engine.time_scale = 0
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	paused = !paused




func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_volume_value_changed(value):
	AudioServer.set_bus_volume_db(0, value)


func _on_check_box_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0, toggled_on)


func _on_resolutions_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(3840,2160))
		1:
			DisplayServer.window_set_size(Vector2i(2560,1440))
		2:
			DisplayServer.window_set_size(Vector2i(1920,1080))
		3:
			DisplayServer.window_set_size(Vector2i(1600,900))
		4:
			DisplayServer.window_set_size(Vector2i(1280,720))


func _on_option_button_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
