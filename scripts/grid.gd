class_name Grid
extends RefCounted

var map : Dictionary = {}

func add_node(node : Node3D, coords : Array[Vector3i]):
	for coord in coords:
		assert(map.get(coord) == null)
		map[coord] = node

func get_node(coord : Vector3i) -> Node3D:
	return map.get(coord)

func remove_node(node : Node3D):
	var key = map.find_key(node)
	while key != null:
		map.erase(key)
		key = map.find_key(node)

func overlaps(coords : Array[Vector3i]) -> bool:
	for coord in coords:
		if map.get(coord) != null:
			return true
	return false
