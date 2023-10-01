class_name Builder
extends Node3D

## Represents a visual marker for where a building will
## be built next, and which building.
## This might also be responsible for actually placing the object (?)
@onready var placement_point : Node3D = $display_anchor
var curr_constructible : Constructible = null
var curr_inventory_index : int = -1

signal build(index : int, pos : Vector3)

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

func try_build():
	if curr_inventory_index >= 0:
		if curr_constructible.can_build():
			build.emit(curr_inventory_index, position)
		else:
			print("Can't build there")
		
func select_constructible(index: int, s : PackedScene):
	if index == curr_inventory_index:
		return
	placement_point.remove_child(curr_constructible)
	curr_constructible = null
	curr_inventory_index = index
	if index >= 0:
		curr_constructible = s.instantiate() as Constructible
		curr_constructible.make_candidate()
		placement_point.add_child(curr_constructible)

func _process(delta):
	pass
