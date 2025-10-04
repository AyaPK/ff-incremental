class_name BattleScene extends Node2D

const CHARACTER_SLOT = preload("uid://dxsrhy7oue3kw")
const CHARACTER_STAT_BAR = preload("uid://uik7qxyygjte")

var character_slot_1: CharacterSlot

@onready var character_1_position: Marker2D = $Character1Position
@onready var char_stats: VBoxContainer = $CharStats/CharStatsBox

func _ready() -> void:
	BattleManager.battle_scene = self

func _process(_delta: float) -> void:
	pass

func spawn_character() -> void:
	character_slot_1 = CHARACTER_SLOT.instantiate()
	character_slot_1.character = PartyManager.get_party_slot(1)
	add_child(character_slot_1)
	character_slot_1.global_position = character_1_position.global_position
	
	var char_stat_bar: CharStatBar = CHARACTER_STAT_BAR.instantiate()
	char_stat_bar.character_slot = character_slot_1
	char_stats.add_child(char_stat_bar)
