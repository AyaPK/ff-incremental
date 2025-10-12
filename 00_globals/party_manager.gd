extends Node

const SAVE_PATH := "user://savefile.save"

var member_1: Character
var member_2: Character
var member_3: Character
var member_4: Character

func _ready() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		load_characters()
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
	character.speed = 5.0
	character.attack = 5
	character.defense = 5
	character.level = 1
	character.experience = 0
	return character

func save_characters() -> void:
	var character_save: Dictionary = {
		"1" : {
			"job": member_1.job,
			"max_hp": member_1.max_hp,
			"hp": member_1.hp,
			"speed": member_1.speed,
			"attack": member_1.attack,
			"defense": member_1.defense,
			"level": member_1.level,
			"experience": member_1.experience
		}
	}
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(character_save))
	file.close()

func load_characters() -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json_data = JSON.parse_string(file.get_as_text())
	file.close()
	
	member_1 = Character.new()
	member_1.job = json_data["1"]["job"]
	member_1.max_hp = json_data["1"]["max_hp"]
	member_1.hp = json_data["1"]["hp"]
	member_1.speed = json_data["1"]["speed"]
	member_1.attack = json_data["1"]["attack"]
	member_1.defense = json_data["1"]["defense"]
	member_1.level = json_data["1"]["level"]
	member_1.experience = json_data["1"]["experience"]
	member_1.image = load("res://assets/sprites/characters/"+member_1.job+".png")
