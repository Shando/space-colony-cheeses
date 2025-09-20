# Simple Free-Look Camera 1.0 Scripts 3.2 Community
# Submitted by user aloivmada; MIT; 2020-08-21
extends Camera3D

var _mouse_position = Vector2(0.0, 0.0)
var _total_pitch = 0.0
var _direction = Vector3(0.0, 0.0, 0.0)
var _velocity = Vector3(0.0, 0.0, 0.0)
var _vel_multiplier = 10
var _w = false
var _s = false
var _a = false
var _d = false
var _down = false
var _up = false

func _ready():
	position = Vector3(25, 70, 40)
	rotation_degrees = Vector3(-60, 0, 0)

func _input(event):
	# Receives mouse motion
	if event is InputEventMouseMotion:
		_mouse_position = event.relative

	# Receives mouse button input
	if event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_RIGHT: # Only allows rotation if right click down
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED if event.pressed else Input.MOUSE_MODE_VISIBLE)
			MOUSE_BUTTON_WHEEL_UP: # Increases max velocity
				_vel_multiplier = clamp(_vel_multiplier * 1.1, 0.2, 20)
			MOUSE_BUTTON_WHEEL_DOWN: # Decereases max velocity
				_vel_multiplier = clamp(_vel_multiplier / 1.1, 0.2, 20)

	# Receives key input
	if event is InputEventKey:
		match event.keycode:
			KEY_W:
				_w = event.pressed
			KEY_S:
				_s = event.pressed
			KEY_A:
				_a = event.pressed
			KEY_D:
				_d = event.pressed
			KEY_DOWN:
				_down = event.pressed
			KEY_UP:
				_up = event.pressed

func _process(delta):
	_update_mouselook()
	_update_movement(delta)

func _update_movement(delta):
	# Computes desired direction from key states
	_direction = Vector3(float(_d) - float(_a), float(_up) - float(_down), float(_s) - float(_w))

	# Computes the change in velocity due to desired direction and "drag"
	# The "drag" is a constant acceleration on the camera to bring it's velocity to 0
	var offset = _direction.normalized() * 30 * _vel_multiplier * delta \
		+ _velocity.normalized() * -10 * _vel_multiplier * delta
	
	# Checks if we should bother translating the camera
	if _direction == Vector3.ZERO and offset.length_squared() > _velocity.length_squared():
		# Sets the velocity to 0 to prevent jittering due to imperfect deceleration
		_velocity = Vector3.ZERO
	else:
		# Clamps speed to stay within maximum value (_vel_multiplier)
		_velocity.x = clamp(_velocity.x + offset.x, -_vel_multiplier, _vel_multiplier)
		_velocity.y = clamp(_velocity.y + offset.y, -_vel_multiplier, _vel_multiplier)
		_velocity.z = clamp(_velocity.z + offset.z, -_vel_multiplier, _vel_multiplier)
		translate(_velocity * delta)

		if position.x < -55:
			position.x = -55
		elif position.x > 105:
			position.x = 105

		if position.y < 5:
			position.y = 5
		elif position.y > 80:
			position.y = 80

		if position.z < -40:
			position.z = -40
		elif position.z > 60:
			position.z = 60

func _update_mouselook():
	# Only rotates mouse if the mouse is captured
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		_mouse_position *= 0.25
		var yaw = _mouse_position.x
		var pitch = _mouse_position.y
		_mouse_position = Vector2(0, 0)
		# Prevents looking up/down too far
		pitch = clamp(pitch, -75 - _total_pitch, -5 - _total_pitch)
		_total_pitch += pitch
		rotate_y(deg_to_rad(-yaw))
		rotate_object_local(Vector3(1,0,0), deg_to_rad(-pitch))
