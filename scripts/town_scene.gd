class_name TownPanel extends ScenePanel

@onready var town_image: TextureRect = %TownImage
@onready var area_name: Label = $TextureRect/AreaName

var current_town: Town:
	get: return load(towns[town_index]["res"])

var towns: Array[Dictionary] = [
	{ "name":"cornelia", "res": "res://towns/cornelia.tres"},
]
var town_index: int

func _ready() -> void:
	town_index = 0
	load_town()

func load_town():
	town_image.texture = current_town.graphic
	area_name.text = current_town.name
