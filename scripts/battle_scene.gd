class_name BattleScene extends Node2D

const CHARACTER_SLOT = preload("uid://dxsrhy7oue3kw")

var character_slot_1: CharacterSlot

@onready var character_1_position: Marker2D = $Character1Position

func _ready() -> void:
	BattleManager.battle_scene = self

func _process(_delta: float) -> void:
	pass

func spawn_character() -> void:
	character_slot_1 = CHARACTER_SLOT.instantiate()
	character_slot_1.character = PartyManager.get_party_slot(1)
	add_child(character_slot_1)
	character_slot_1.global_position = character_1_position.global_position
