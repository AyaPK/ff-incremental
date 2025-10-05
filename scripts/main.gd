extends Node2D

func _ready() -> void:
	BattleManager.load_player()
	_on_show_battle_pressed()

func _process(_delta: float) -> void:
	pass


func _on_hide_battle_pressed() -> void:
	$BattleScene.process_mode = Node.PROCESS_MODE_DISABLED
	$BattleScene.hide()


func _on_show_battle_pressed() -> void:
	$BattleScene.process_mode = Node.PROCESS_MODE_ALWAYS
	$BattleScene.refresh_stats()
	BattleManager.load_enemy("goblin")
	$BattleScene.character_slot_1.move_timer.start()
	$BattleScene.enemy_slot_1.move_timer.start()
	$BattleScene.show()


func _on_heal_pressed() -> void:
	PartyManager.get_party_slot(1).hp = 10
	$BattleScene.refresh_stats()
