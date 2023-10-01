class_name InventoryDisplay
extends Control

@export var inventory : Inventory
signal item_selected(index : int)

const item_display : PackedScene = preload("res://scenes/inventory_item_button.tscn")

func select_item(index : int):
	item_selected.emit(index)
	
func _update_item_count(index : int, count : int):
	(get_child(index) as InventoryItemButton).set_item_count(count)

func set_contents(contents : Array[LevelResourceDef]):
	# Clear all children, just in-case
	for node in get_children():
		remove_child(node)
		node.queue_free()
	
	# Add new children
	var i : int = 0
	for item in contents:
		var display = item_display.instantiate()
		display.set_resource(item)
		add_child(display)
		display.connect("button_up", func(): select_item(i))
		i += 1

# Called when the node enters the scene tree for the first time.
func _ready():
	inventory.connect("update_item_count", _update_item_count)
	var i : int = 0
	for item in inventory.contents:
		var display = item_display.instantiate()
		display.set_resource(item)
		add_child(display)
		display.connect("button_up", func(): select_item(i))
		i += 1
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
