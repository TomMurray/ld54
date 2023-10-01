class_name Level
extends Node3D

@export var inventory : Inventory

func build_item(inventory_index : int, pos : Vector3):
	var new_item_scene = inventory.use_item(inventory_index)
	if new_item_scene:
		# Get scene from inventory and instantiate it, place it in the scene
		var inst = new_item_scene.instantiate() as Constructible
		add_child(inst)
		inst.position = pos
	else:
		print("Failed to build item at inventory index %d" % inventory_index)
	
