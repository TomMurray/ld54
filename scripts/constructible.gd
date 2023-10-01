class_name Constructible
extends Node3D

@export var collision_object : CollisionObject3D
@export var visual_element : GeometryInstance3D

var _unplaceable_mat = preload("res://resources/materials/unplaceable.tres") as Material
@onready var _orig_mat = visual_element.material_override 

var _bodies_overlapping : Dictionary = {}

func _body_entered(body : Node3D):
	if _bodies_overlapping.is_empty():
		visual_element.material_override = _unplaceable_mat
	_bodies_overlapping[body] = true

func _body_exited(body : Node3D):
	_bodies_overlapping.erase(body)
	if _bodies_overlapping.is_empty():
		visual_element.material_override = _orig_mat

func make_candidate():
	var cs = collision_object.get_children()
	var area : Area3D = Area3D.new()
	for c in cs:
		collision_object.remove_child(c)
		area.add_child(c)
	area.connect("body_entered", _body_entered)
	area.connect("body_exited", _body_exited)
	area.scale = Vector3.ONE * 0.98
	visual_element.transparency = 0.2
	visual_element.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	collision_object.get_parent().add_child(area)
	collision_object.queue_free()
	collision_object = area
	
