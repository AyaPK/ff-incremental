extends Node

const SAVE_PATH := "user://resource.save"

var gp: int

signal saved

var inventory: Array[Item] = [
	
]

var rarity_colours: Dictionary = {
	0: Color.DIM_GRAY,
	1: Color.GREEN,
	2: Color.BLUE,
	3: Color.PURPLE,
	4: Color.GOLD,
	5: Color.AQUA
}

func _ready() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		load_file()

func save_file() -> void:
	# serial inventory
	var inv: Array[String]
	for item in inventory:
		inv.append(item.resource_path)
		
	var resource_save: Dictionary = {
		"gp": gp,
		"inventory": inv,
	}
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(resource_save))
	file.close()
	saved.emit()

func load_file() -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json_data = JSON.parse_string(file.get_as_text())
	file.close()
	
	gp = json_data["gp"]
	var inv: Array[Item] = []
	for item in json_data["inventory"]:
		inv.append(load(item))
	inventory = inv

func get_all_weapons() -> Array[Equippable]:
	var weapons: Array[Equippable] = []
	for i in inventory:
		if i.has_method("is_mainhand"):
			weapons.append(i)
	return weapons
