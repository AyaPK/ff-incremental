extends Node2D

var state: String
var open_scene: Node2D

func _ready() -> void:
	BattleManager.load_player()
	$BattleScene.process_mode = Node.PROCESS_MODE_DISABLED

func _process(_delta: float) -> void:
	pass

func _on_explore_pressed() -> void:
	if state != "explore":
		if open_scene:
			open_scene.hide()
		open_scene = $BattleScene
		state = "explore"
		$BattleScene.process_mode = Node.PROCESS_MODE_ALWAYS
		$BattleScene.refresh_stats()
		$BattleScene.change_area(BattleManager.get_area_name(BattleManager.area_index))
		$BattleScene.character_slot_1.move_timer.start()
		$BattleScene.enemy_slot_1.move_timer.start()
		$BattleScene.show()


func _on_inn_button_pressed() -> void:
	if state != "inn":
		if open_scene:
			open_scene.hide()
		open_scene = $InnScene
		state = "inn"
		$InnScene.show()
		$InnScene.calculate_cost()
