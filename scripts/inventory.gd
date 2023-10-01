class_name Inventory
extends Node3D

@export var contents : Array[LevelResourceDef]

signal select_item(index : int, s : PackedScene)

signal update_item_count(index : int, count : int)

func use_item(index : int):
	contents[index].available_count -= 1
	update_item_count.emit(index, contents[index].available_count)


func _on_inventory_display_item_selected(index):
	select_item.emit(index, contents[index].constructible)
