class_name BattleScene extends Node2D

const CHARACTER_SLOT = preload("uid://dxsrhy7oue3kw")
const CHARACTER_STAT_BAR = preload("uid://uik7qxyygjte")
const ENEMY_SLOT = preload("uid://b0dgj6tk3ed4a")

var character_slot_1: CharacterSlot
var enemy_slot_1: EnemySlot

var encounter_table: EncounterTable

@onready var character_1_position: Marker2D = $Character1Position
@onready var char_stats: VBoxContainer = $CharStats/CharStatsBox

@onready var enemy_1_position: Marker2D = $Enemy1Position

@onready var background_image: TextureRect = $Panel/BackgroundImage

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
	if enemy_slot_1:
		enemy_slot_1.queue_free()
	enemy_slot_1 = ENEMY_SLOT.instantiate()
	enemy_slot_1.enemy_resource = enemy
	add_child(enemy_slot_1)
	enemy_slot_1.global_position = enemy_1_position.global_position

func pause_timers() -> void:
	character_slot_1.move_timer.paused = true
	if enemy_slot_1:
		enemy_slot_1.move_timer.paused = true

func start_timers() -> void:
	character_slot_1.move_timer.paused = false
	if enemy_slot_1:
		enemy_slot_1.move_timer.paused = false

func refresh_stats() -> void:
	for c: CharStatBar in char_stats.get_children():
		c.refresh_stats()

func _on_button_pressed() -> void:
	BattleManager.load_enemy("goblin")

func change_area(area_name: String) -> void:
	var res: AreaResource = load("res://areas/area_resources/"+area_name+".tres")
	background_image.texture = res.background
	encounter_table = res.encounter_table
	var enemy = encounter_table.enemies.pick_random()
	spawn_enemy(enemy)
	if BattleManager.area_index <= 0:
		$AreaChanger/LeftButton.disabled = true
	elif BattleManager.area_index >= len(BattleManager.areas)-1:
		$AreaChanger/RightButton.disabled = true
	character_slot_1.move_timer.start()
	enemy_slot_1.move_timer.start()


func _on_right_button_pressed() -> void:
	BattleManager.area_index += 1
	change_area(BattleManager.get_area_name(BattleManager.area_index))
	if $AreaChanger/LeftButton.disabled == true:
		$AreaChanger/LeftButton.disabled = false

func _on_left_button_pressed() -> void:
	BattleManager.area_index -= 1
	change_area(BattleManager.get_area_name(BattleManager.area_index))
	if $AreaChanger/RightButton.disabled == true:
		$AreaChanger/RightButton.disabled = false
