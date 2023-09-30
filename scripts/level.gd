extends Node3D

const LevelResourceDef = preload("res://scripts/level_resource_def.gd")

@export var bounds : Area3D
@export var level_res : Array[LevelResourceDef]
