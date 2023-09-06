extends Node3D

@export var max_rotation = PI

var _is_dragging = false
var _last_angle_to = 0

@onready var Wheel: TextureRect = get_node("UI/Control/Wheel")

func _get_wheel_center():
	return Wheel.get_node("Center").global_position	

# We check is the mouse button was released or dragged globally (in case the mouse is outside of the control) 
func _input(event: InputEvent):
	if _is_dragging:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
				_is_dragging = false
		elif event is InputEventMouse:
			var mouse_position = Wheel.get_global_mouse_position()
			var angle_to = _get_wheel_center().angle_to_point(mouse_position)
			Wheel.rotation -= _last_angle_to - angle_to
			_last_angle_to = angle_to

			if Wheel.rotation > max_rotation:
				Wheel.rotation = max_rotation
			elif Wheel.rotation < -max_rotation:
				Wheel.rotation = -max_rotation

# Listen if the the user pressed the left mouse on the steering wheel
func _on_wheel_gui_input(event: InputEvent):
	if not _is_dragging and event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			_is_dragging = true
			_last_angle_to = _get_wheel_center().angle_to_point(event.global_position)
