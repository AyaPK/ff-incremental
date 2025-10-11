extends Node

const SAVE_PATH := "user://resource.save"

var gp: int

func _ready() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		load_file()

func save_file() -> void:
	var resource_save: Dictionary = {
		"gp": gp
	}
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(resource_save))
	file.close()

func load_file() -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json_data = JSON.parse_string(file.get_as_text())
	file.close()
	
	gp = json_data["gp"]
