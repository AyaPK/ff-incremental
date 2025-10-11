extends Node

const SAVE_PATH := "user://savefile.save"

var member_1: Character
var member_2: Character
var member_3: Character
var member_4: Character

func _ready() -> void:
	
	if FileAccess.file_exists(SAVE_PATH):
		member_1 = load_character()
	else:
		member_1 = create_new_character("warrior")

func get_party() -> Array[Character]:
	var party_array: Array[Character] = []
	if member_1:
		party_array.append(member_1)
	if member_2:
		party_array.append(member_2)
	if member_3:
		party_array.append(member_3)
	if member_4:
		party_array.append(member_4)
	return party_array

func get_party_slot(num: int) -> Character:
	return get_party()[num-1]

func create_new_character(job: String) -> Character:
	var character: Character = Character.new()
	character.job = job
	character.max_hp = 10
	character.hp = 10
	character.image = load("res://assets/sprites/characters/"+character.job+".png")
	character.speed = 0.5
	character.attack = 5
	character.defense = 5
	character.level = 1
	character.experience = 0
	return character

func save_character(character: Character) -> void:
	var character_save: Dictionary = {
		"job": character.job,
		"max_hp": character.max_hp,
		"hp": character.hp,
		"speed": character.speed,
		"attack": character.attack,
		"defense": character.defense,
		"level": character.level,
		"experience": character.experience
	}
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(character_save))
	file.close()

func load_character() -> Character:
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json_data = JSON.parse_string(file.get_as_text())
	file.close()

	var character: Character = Character.new()
	character.job = json_data["job"]
	character.max_hp = json_data["max_hp"]
	character.hp = json_data["hp"]
	character.speed = json_data["speed"]
	character.attack = json_data["attack"]
	character.defense = json_data["defense"]
	character.level = json_data["level"]
	character.experience = json_data["experience"]
	character.image = load("res://assets/sprites/characters/"+character.job+".png")
	return character
