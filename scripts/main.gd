extends Node2D

var state: String

func _ready() -> void:
	BattleManager.load_player()
	_on_hide_battle_pressed()

func _process(_delta: float) -> void:
	pass

func _on_hide_battle_pressed() -> void:
	state = "hide"
	$BattleScene.process_mode = Node.PROCESS_MODE_DISABLED
	$BattleScene.hide()

func _on_explore_pressed() -> void:
	if state != "explore":
		state = "explore"
		$BattleScene.process_mode = Node.PROCESS_MODE_ALWAYS
		$BattleScene.refresh_stats()
		$BattleScene.change_area("nearby_plains")
		$BattleScene.character_slot_1.move_timer.start()
		$BattleScene.enemy_slot_1.move_timer.start()
		$BattleScene.show()


func _on_heal_pressed() -> void:
	PartyManager.member_1.hp = PartyManager.member_1.max_hp
	$BattleScene.refresh_stats()
