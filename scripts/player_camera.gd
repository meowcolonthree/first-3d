extends Camera3D

@export var mouse_sensitivity = 20

func _input(event: InputEvent):
	if event is InputEventMouseMotion:
		var movement: Vector2 = event.relative
		$Pivot.rotate_x(movement.x/mouse_sensitivity)
