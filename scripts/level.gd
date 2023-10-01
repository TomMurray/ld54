class_name Level
extends Node3D

@export var inventory : Inventory

func build_item(inventory_index : int, pos : Vector3):
	# Get scene from inventory and instantiate it, place it in the scene
	var inst = inventory.contents[inventory_index].constructible.instantiate() as Constructible
	add_child(inst)
	inst.position = pos
