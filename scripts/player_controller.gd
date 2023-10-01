@tool
extends Node3D

@export var move_speed_per_sec : float = 30.0
@export var move_speed_drag : float = 25.0
@export var rotate_deg_per_sec : float = 200.0
@export var rotate_drag_deg : float = 360.0
@export var max_zoom : float = 0.2
@export var min_zoom : float = 2.0
@export var zoom_step : float = 0.1
@export var builder : Builder
@onready var cam : Camera3D = $Camera3D
@onready var cam_offset_original : Vector3 = cam.position
var zoom : float = 0.5

func _move_in_facing_direction(delta : Vector3):
	var flattened_x_basis = -transform.basis.x.slide(Vector3.UP)
	var flattened_z_basis = -transform.basis.z.slide(Vector3.UP)
	delta = delta.x * flattened_x_basis + delta.z * flattened_z_basis
	position += delta
	
func _rotate_camera_deg(delta : float):
	rotate(Vector3.UP, deg_to_rad(delta))

func _on_zoom_changed():
	zoom = clamp(zoom, 0.0, 1.0)
	cam.position = cam_offset_original * lerpf(min_zoom, max_zoom, zoom)

func _input(event):
	if event.is_action("zoom_out"):
		zoom -= (event as InputEventMouseButton).factor * zoom_step
		_on_zoom_changed()
	elif event.is_action("zoom_in"):
		zoom += (event as InputEventMouseButton).factor * zoom_step
		_on_zoom_changed()
	elif event is InputEventMouseMotion:
		var moved = (event as InputEventMouseMotion).relative
		if Input.is_action_pressed("rotate_drag"):
			var rotate_deg = (moved.x / get_viewport().get_visible_rect().size.x) * rotate_drag_deg
			_rotate_camera_deg(rotate_deg)
		if Input.is_action_pressed("move_drag"):
			var delta_pos = (-moved / get_viewport().get_visible_rect().size) * move_speed_drag
			_move_in_facing_direction(Vector3(delta_pos.x, 0.0, delta_pos.y))

func _physics_process(delta):
	if Engine.is_editor_hint():
		return
	
	var mouse_pos = get_viewport().get_mouse_position()
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(cam.project_ray_origin(mouse_pos), cam.project_ray_normal(mouse_pos) * 1000.0)
	var result = space_state.intersect_ray(query)
	var target_pos = null
	if not result.is_empty():
		target_pos = result.position + result.normal * 0.05
	builder.move_to(target_pos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not Engine.is_editor_hint():
		var pos_delta = Vector3.ZERO
		if Input.is_action_pressed("move_left"):
			pos_delta.x -= 1.0
		if Input.is_action_pressed("move_right"):
			pos_delta.x += 1.0
		if Input.is_action_pressed("move_forward"):
			pos_delta.z -= 1.0
		if Input.is_action_pressed("move_backward"):
			pos_delta.z += 1.0
		pos_delta = pos_delta.normalized() * move_speed_per_sec * delta
		
		var rotation_delta = 0.0
		if Input.is_action_pressed("rotate_anticlockwise"):
			rotation_delta += 1.0
		elif Input.is_action_pressed("rotate_clockwise"):
			rotation_delta -= 1.0
		
		_move_in_facing_direction(pos_delta)
		_rotate_camera_deg(rotation_delta * rotate_deg_per_sec * delta)
	
	cam.look_at(position)
	
