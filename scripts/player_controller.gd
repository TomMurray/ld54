@tool
extends Node3D

@export var move_speed_per_sec : float = 30.0
@export var max_zoom : float = 0.2
@export var min_zoom : float = 2.0
@export var zoom_step : float = 0.1
@onready var cam : Camera3D = $Camera3D
@onready var cam_offset_original : Vector3 = cam.position
var zoom : float = 1.0 

func _input(event):
	if event.is_action("zoom_out"):
		zoom += (event as InputEventMouseButton).factor * zoom_step
	elif event.is_action("zoom_in"):
		zoom -= (event as InputEventMouseButton).factor * zoom_step
	zoom = clamp(zoom, max_zoom, min_zoom)
	cam.position = cam_offset_original * zoom

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var pos_delta = Vector3.ZERO
	if Input.is_action_pressed("move_left"):
		pos_delta.x -= 1.0
	if Input.is_action_pressed("move_right"):
		pos_delta.x += 1.0
	if Input.is_action_pressed("move_forward"):
		pos_delta.z -= 1.0
	if Input.is_action_pressed("move_backward"):
		pos_delta.z += 1.0
	pos_delta = pos_delta.normalized() * delta
	
	# This slightly arcane looking statement means:
	# Take the vector representing the way the camera is looking
	# and slide it along a flat plane, which has the effect of removing
	# any rotation that would face it down or upwards
	var flattened_x_basis = -transform.basis.x.slide(Vector3.UP)
	var flattened_z_basis = -transform.basis.z.slide(Vector3.UP)
	print("Flattened z basis? %s" % flattened_z_basis)
	pos_delta = pos_delta.x * flattened_x_basis + pos_delta.z * flattened_z_basis
	
	position += pos_delta
	
	
	cam.look_at(position)
	
