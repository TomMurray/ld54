class_name Builder
extends Node3D

## Represents a visual marker for where a building will
## be built next, and which building.
## This might also be responsible for actually placing the object (?)

# Take a reference to a level
@export var level : Level
@onready var placement_point : Node3D = $display_anchor
var curr_constructible : Constructible = null

const selected_constructible : PackedScene = preload("res://scenes/constructibles/house_small.tscn")


func make_a_move(pos):
	if not pos:
		visible = false
		return
	visible = true
	position = pos as Vector3

func try_build():
	print("try_build")
	

func _ready():
	curr_constructible = selected_constructible.instantiate() as Constructible
	curr_constructible.make_candidate()
	placement_point.add_child(curr_constructible)

func _process(delta):
	pass
