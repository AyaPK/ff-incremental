class_name BattleScene extends Node2D

const CHARACTER_SLOT = preload("uid://dxsrhy7oue3kw")
const CHARACTER_STAT_BAR = preload("uid://uik7qxyygjte")
const ENEMY_SLOT = preload("uid://b0dgj6tk3ed4a")

var character_slot_1: CharacterSlot

var enemy_slot_1: EnemySlot

@onready var character_1_position: Marker2D = $Character1Position
@onready var char_stats: VBoxContainer = $CharStats/CharStatsBox

@onready var enemy_1_position: Marker2D = $Enemy1Position


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

func spawn_enemy(enemy: EnemyResource) -> void:
	enemy_slot_1 = ENEMY_SLOT.instantiate()
	enemy_slot_1.enemy_resource = enemy
	enemy_slot_1.process_resource()
	add_child(enemy_slot_1)
	enemy_slot_1.global_position = enemy_1_position.global_position
