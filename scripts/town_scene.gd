class_name TownPanel extends ScenePanel

@onready var town_image: TextureRect = %TownImage
@onready var area_name: Label = $TextureRect/AreaName
@onready var store_panel: StorePanel = $StorePanel

var current_town: Town:
	get: return load(towns[BattleManager.town_index]["res"])

var towns: Array[Dictionary] = [
	{ "name":"cornelia", "res": "res://towns/cornelia.tres"},
	{ "name":"provoka", "res": "res://towns/pravoka.tres"},
]
var town_index: int

func run_on_enter() -> void:
	store_panel.hide()
	load_town()
	show()

func run_on_exit() -> void:
	store_panel.hide()

func load_town() -> void:
	town_image.texture = current_town.graphic
	area_name.text = current_town.name

func _on_weaponry_pressed() -> void:
	store_panel.store_resource = current_town.weapon_store
	store_panel.load_store()
	store_panel.show()
