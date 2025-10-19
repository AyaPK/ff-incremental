class_name BattleScene extends ScenePanel

const CHARACTER_SLOT = preload("uid://dxsrhy7oue3kw")
const CHARACTER_STAT_BAR = preload("uid://uik7qxyygjte")
const ENEMY_SLOT = preload("uid://b0dgj6tk3ed4a")

var character_slot_1: CharacterSlot
var enemy_slot_1: EnemySlot
var respawning: bool = false

var encounter_table: EncounterTable

@onready var character_1_position: Marker2D = $Character1Position
@onready var char_stats: VBoxContainer = $CharStats/CharStatsBox

@onready var enemy_1_position: Marker2D = $Enemy1Position

@onready var background_image: TextureRect = $Panel/BackgroundImage
@onready var area_name: Label = $AreaChanger/TextureRect/AreaName
@onready var respawn_timer: Timer = $RespawnTimer
@onready var respawn_bar: TextureProgressBar = $RespawnBar

func run_on_enter() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	refresh_stats()
	change_area(BattleManager.get_area_name(BattleManager.area_index))
	character_slot_1.move_timer.start()
	enemy_slot_1.move_timer.start()
	restart_timers()

func run_on_exit() -> void:
	restart_timers()
	pause_timers()

func _ready() -> void:
	BattleManager.battle_scene = self
	respawn_bar.hide()

func _process(_delta: float) -> void:
	if BattleManager.dead:
		pause_timers()
	elif !enemy_slot_1 and !respawning:
		pause_timers()
		respawn_timer.start()
		respawn_bar.value = (respawn_timer.wait_time-respawn_timer.time_left) * 100
		respawning = true
		respawn_bar.show()
	elif !enemy_slot_1:
		respawn_bar.value = (respawn_timer.wait_time-respawn_timer.time_left) * 100
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
	restart_timers()

func pause_timers() -> void:
	character_slot_1.move_timer.paused = true
	if enemy_slot_1:
		enemy_slot_1.move_timer.paused = true

func start_timers() -> void:
	character_slot_1.move_timer.paused = false
	if enemy_slot_1:
		enemy_slot_1.move_timer.paused = false

func restart_timers() -> void:
	character_slot_1.move_timer.paused = false
	character_slot_1.move_timer.start()
	if enemy_slot_1:
		enemy_slot_1.move_timer.paused = false
		enemy_slot_1.move_timer.start()

func refresh_stats() -> void:
	for c: CharStatBar in char_stats.get_children():
		c.refresh_stats()

func change_area(new_area_name: String) -> void:
	var res: AreaResource = load("res://areas/area_resources/"+new_area_name+".tres")
	background_image.texture = res.background
	encounter_table = res.encounter_table
	respawn_bar.hide()
	var enemy = encounter_table.enemies.pick_random()
	spawn_enemy(enemy)
	if BattleManager.area_index <= 0:
		$AreaChanger/LeftButton.disabled = true
	elif BattleManager.area_index >= len(BattleManager.areas)-1:
		$AreaChanger/RightButton.disabled = true
	character_slot_1.move_timer.start()
	enemy_slot_1.move_timer.start()
	$AreaChanger/TextureRect/AreaName.text = res.name
	BattleManager.town_index = res.town_index

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

func _on_respawn_timer_timeout() -> void:
	var enemy = encounter_table.enemies.pick_random()
	spawn_enemy(enemy)
	respawning = false
	respawn_bar.hide()
	restart_timers()
