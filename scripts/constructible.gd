class_name Constructible
extends Node3D

@export var collision_object : CollisionObject3D

# Passthrough collision layer to allow disabling collisions
var collision_layer : int = 0 :
	get: return collision_object.collision_layer
	set(value): collision_object.collision_layer = value

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
