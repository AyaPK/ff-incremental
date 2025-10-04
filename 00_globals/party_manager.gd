extends Node

var member_1: Character
var member_2: Character
var member_3: Character
var member_4: Character

func _ready() -> void:
	var character: Character = Character.new()
	character.job = "fighter"
	character.max_hp = 10
	character.hp = 10
	character.image = load("res://assets/sprites/characters/"+character.job+".png")
	character.speed = 5.0
	member_1 = character
	
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
	print(party_array)
	return party_array

func get_party_slot(num: int) -> Character:
	return get_party()[num-1]
