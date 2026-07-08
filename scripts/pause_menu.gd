extends Control

@onready var main = $"../"
@onready var settings: MarginContainer = $Settings
@onready var pause: MarginContainer = $Pause

@onready var volume_slider: HSlider = $Settings/VBoxContainer/Volume
@onready var muted_box: CheckBox = $Settings/VBoxContainer/Muted
@onready var resolutions_menu: OptionButton = $Settings/VBoxContainer/Resolutions
@onready var fullscreen_mode_menu: OptionButton = $Settings/VBoxContainer/FullscreenMode

var paused = false
var config = ConfigFile.new()

func _ready():
	pause.hide()
	settings.hide()
	config.set_value("Player", "Volume", 0)
	load_settings()

func _on_resume_pressed() -> void:
	pause_func()

func _on_settings_pressed() -> void:
	settings.show()
	pause.hide()

func _input(event: InputEvent):
	if event.is_action_pressed("mouse_capture_toggle") and settings.visible:
		save_settings()
		settings.hide()
		pause.show()
	elif event.is_action_pressed("mouse_capture_toggle") and not settings.visible:
		pause_func()
		
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
	config.set_value("Player", "Volume", value)
	
func _on_muted_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0, toggled_on)
	config.set_value("Player", "Muted", toggled_on)

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
	config.set_value("Player", "Resolution", index)

func _on_fullscreen_mode_item_selected(index: int) -> void:
	
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	config.set_value("Player", "FullscreenMode", index)

func _on_save_settings_pressed() -> void:
	save_settings()
	settings.hide()
	pause.show()


func save_settings():
	config.save("user://settings.cfg")
	
func load_settings():
	var configload = config.load("user://settings.cfg")
	if configload != OK:
		return
	for player in config.get_sections():
		var volume = config.get_value(player, "Volume")
		var resolution = config.get_value(player, "Resolution")
		var fullscreenMode = config.get_value(player, "FullscreenMode")
		var muted = config.get_value(player, "Muted")
		_on_volume_value_changed(volume)
		_on_muted_toggled(muted)
		_on_resolutions_item_selected(resolution)
		_on_fullscreen_mode_item_selected(fullscreenMode)
		volume_slider.value = volume
		muted_box.button_pressed = muted
		resolutions_menu.selected = resolution
		fullscreen_mode_menu.selected = fullscreenMode
		
