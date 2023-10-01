class_name Builder
extends Node3D

## Represents a visual marker for where a building will
## be built next, and which building.
## This might also be responsible for actually placing the object (?)
@onready var placement_point : Node3D = $display_anchor
@onready var str_error : AudioStreamPlayer = $str_error
@onready var str_build : AudioStreamPlayer3D = $str_build
var curr_constructible : Constructible = null
var curr_inventory_index : int = -1

signal build(index : int, pos : Vector3, basis : Basis)

func move_to(pos):
	if not pos:
		visible = false
		return
	visible = true
	
	# Round position to grid coordinates
	pos = Vector3(
		floorf(pos.x + 0.5),
		floorf(pos.y + 0.5),
		floorf(pos.z + 0.5)
	)
	position = pos as Vector3

# Feels ugly but...sure
func _unhandled_input(event):
	if event.is_action_pressed("build"):
		try_build()

func _input(event):
	if event.is_action_pressed("rotate_obj_90_clockwise"):
		placement_point.rotate(Vector3.UP, deg_to_rad(90))
	elif event.is_action_pressed("rotate_obj_90_anticlockwise"):
		placement_point.rotate(Vector3.UP, deg_to_rad(-90))

func try_build():
	if curr_inventory_index >= 0:
		if curr_constructible.can_build():
			str_build.play()
			build.emit(curr_inventory_index, position, placement_point.basis)
		else:
			str_error.play()
		
func select_constructible(index: int, s : PackedScene):
	if index == curr_inventory_index:
		return
	if curr_constructible:
		placement_point.remove_child(curr_constructible)
	curr_constructible = null
	curr_inventory_index = index
	placement_point.basis = Basis.IDENTITY
	if index >= 0:
		curr_constructible = s.instantiate() as Constructible
		curr_constructible.make_candidate()
		placement_point.add_child(curr_constructible)

func _process(delta):
	pass


func _on_inventory_update_item_count(index, count):
	if index == curr_inventory_index:
		if count <= 0:
			select_constructible(-1, null)
