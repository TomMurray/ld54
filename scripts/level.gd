class_name Level
extends Node3D

@export var level_res : Array[LevelResourceDef]
@export var res_display : InventoryDisplay

func _ready():
	# Setup inventory display
	res_display.set_contents(level_res)
