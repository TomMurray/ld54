class_name Builder
extends Node3D

## Represents a visual marker for where a building will
## be built next, and which building.
## This might also be responsible for actually placing the object (?)

# Take a reference to a level
@export var level : Level
@onready var placement_point : Node3D = $display_anchor

const selected_constructible : PackedScene = preload("res://scenes/constructibles/house_small.tscn")

func make_a_move(pos):
	if not pos:
		visible = false
		return
	visible = true
	position = pos as Vector3

func try_build():
	print("try_build")
	
func _disable_collision_objects(node : Node):
	var body = node as CollisionObject3D
	if body:
		body.collision_layer = 0
		body.collision_mask = 0
	else:
		for child in node.get_children():
			_disable_collision_objects(child)
	

func _ready():
	var constructible = selected_constructible.instantiate() as Constructible
	constructible.collision_layer = 0
	placement_point.add_child(constructible)

func _process(delta):
	pass
