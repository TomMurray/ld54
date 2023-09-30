extends Node3D

const LevelResourceDef = preload("res://scripts/level_resource_def.gd")

@export var bounds : Area3D
@export var level_res : Array[LevelResourceDef]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
