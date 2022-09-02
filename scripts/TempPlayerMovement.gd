extends KinematicBody

export var speed = 10.0
export var jump_strength = 20
export var gravity = 50

var _velocity = Vector3.ZERO
var _snap_vector = Vector3.DOWN

onready var _spring_arm: SpringArm = $SpringArm
onready var _model: Spatial = $MeshInstance

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) #locks mouse to game window

func _physics_process(delta):
	var move_direction = Vector3.ZERO
	#move the character
	move_direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	move_direction.z = Input.get_action_strength("back") - Input.get_action_strength("forward")
	
	
	#move camera relative to character; need to normalize cuz vector math makes them move faster
	move_direction = move_direction.rotated(Vector3.UP, _spring_arm.rotation.y).normalized()

	#speed setting
	if Input.is_action_pressed("sprint"):
		speed = speed + 2
	_velocity.x = move_direction.x * speed
	_velocity.z = move_direction.z * speed
	_velocity.y -= gravity * delta #pull character down over time
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		_velocity.y = jump_strength
		_snap_vector = Vector3.ZERO
	elif is_on_floor() and _snap_vector == Vector3.ZERO:
		_snap_vector = Vector3.DOWN
		
	_velocity = move_and_slide_with_snap(_velocity, _snap_vector, Vector3.UP, true)
	
	if _velocity.length() > 0.2:
		var look_direction = Vector2(_velocity.z, _velocity.x)
		_model.rotation.y = look_direction.angle()

func _process(delta):
	pass
	#_spring_arm.translation = translation
