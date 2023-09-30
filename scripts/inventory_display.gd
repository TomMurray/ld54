class_name InventoryDisplay
extends Control

const item_display : PackedScene = preload("res://scenes/inventory_item_button.tscn")

func set_contents(contents : Array[LevelResourceDef]):
	# Clear all children, just in-case
	for node in get_children():
		remove_child(node)
		node.queue_free()
	
	# Add new children
	for item in contents:
		var display = item_display.instantiate()
		display.set_resource(item)
		add_child(display)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
