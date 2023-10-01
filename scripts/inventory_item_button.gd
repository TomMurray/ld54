class_name InventoryItemButton
extends Button

var photo_stage : PhotoStage
var level_res : LevelResourceDef
var packed_scene : PackedScene
@onready var ui_texture : TextureRect = $render
@onready var remaining_count : Label = $lbl_remaining

func set_resource(r : LevelResourceDef):
	level_res = r

func set_item_count(count : int):
	remaining_count.text = "%d left" % count

# Called when the node enters the scene tree for the first time.
func _ready():
	photo_stage = load("res://scenes/photo_stage.tscn").instantiate()
	photo_stage.set_scene(level_res.constructible)
	photo_stage.texture_baked.connect(_texture_baked)
	add_child(photo_stage)
	level_res = null

func _texture_baked(image : Image):
	ui_texture.texture = ImageTexture.create_from_image(image)
	remove_child(photo_stage)
