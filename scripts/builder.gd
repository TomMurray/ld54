extends Node3D

## Represents a visual marker for where a building will
## be built next, and which building.
## This might also be responsible for actually placing the object (?)

# Take a reference to a level
@export var level : Level

var selected_constructible : PackedScene = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
