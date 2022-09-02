extends SpringArm

export var mouse_sensitivity = 0.05
export var controller_sensitivity = 3

func _ready():
	pass
	#set_as_toplevel(true)
	#become independent from player
	
func _unhandled_input(event):
	
	
	if event is InputEventJoypadMotion:
		var axis_vector = Vector2.ZERO
		axis_vector.x = Input.get_action_strength("look_right") - Input.get_action_strength("look_left")
		axis_vector.y = Input.get_action_strength("look_down") - Input.get_action_strength("look_up")
		rotation_degrees.x = -axis_vector.y * controller_sensitivity
		rotation_degrees.x = clamp(rotation_degrees.x, -90.0, 30.0)
		
		rotation_degrees.y -= axis_vector.x * controller_sensitivity
		rotation_degrees.y = wrapf(rotation_degrees.y, 0.0, 360.0)

	if event is InputEventMouseMotion:
		rotation_degrees.x = -event.relative.y * mouse_sensitivity
		rotation_degrees.x = clamp(rotation_degrees.x, -90.0, 30.0)
		
		rotation_degrees.y -= event.relative.x * mouse_sensitivity
		rotation_degrees.y = wrapf(rotation_degrees.y, 0.0, 360.0) 
