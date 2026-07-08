extends Node3D

@export var mouse_sensitivity: float = 0.005
@export_range(-90.0, 0.0, 0.1, "radians_as_degrees") var min_vertial_angle: float = -PI/2
@export_range(0.0, 90, 0.1, "radians_as_degrees") var max_vertial_angle: float = -PI/2

@onready var spring_arm: SpringArm3D = $SpringArm3D

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _input(event: InputEvent):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotation.y -= event.relative.x * mouse_sensitivity
		rotation.y = wrapf(rotation.y, 0.0, TAU)
		
		rotation.x -= event.relative.y * mouse_sensitivity
		rotation.x = clamp(rotation.x, min_vertial_angle, max_vertial_angle)
	
	if event.is_action_pressed("wheel_up"):
		spring_arm.spring_length -= 1
	if event.is_action_pressed("wheel_down"):
		spring_arm.spring_length += 1
	
	if event.is_action_pressed("mouse_capture_toggle"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
