extends Node3D
@export var mouse_sensitivity = 50

func _input(event: InputEvent):
	if event is InputEventMouseMotion:
		var movement: Vector2 = event.relative
		rotate_y(movement.x / mouse_sensitivity)
		rotate_x(-movement.y / mouse_sensitivity)
