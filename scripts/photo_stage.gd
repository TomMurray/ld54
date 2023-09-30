class_name PhotoStage
extends Node3D

@export var viewport : SubViewport
@export var spawn_anchor : Node3D
var packed_scene : PackedScene

func set_scene(s : PackedScene):
	packed_scene = s

signal texture_baked(image : Image)

# Called when the node enters the scene tree for the first time.
func _ready():
	var inst = packed_scene.instantiate()
	spawn_anchor.add_child(inst)
	# TODO proper centering/scaling of camera or scene

var frame : int = 0
func _process(_delta):
	# Image will only be ready on second frame, this object gets destroyed after that
	if frame > 0:
		var img = viewport.get_texture().get_image()
		texture_baked.emit(img)
		queue_free()
		
	frame += 1
