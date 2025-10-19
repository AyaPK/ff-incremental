extends Node2D

var state: String
var open_scene: ScenePanel

func _ready() -> void:
	BattleManager.load_player()
	$BattleScene.process_mode = Node.PROCESS_MODE_DISABLED

func _process(_delta: float) -> void:
	pass

func _on_explore_pressed() -> void:
	if state != "explore":
		if open_scene:
			open_scene.exit()
		open_scene = $BattleScene
		state = "explore"
		$BattleScene.enter()

func _on_inn_button_pressed() -> void:
	if state != "inn":
		if open_scene:
			open_scene.exit()
		open_scene = $InnScene
		state = "inn"
		$InnScene.enter()

func _on_party_button_pressed() -> void:
	if state != "party":
		if open_scene:
			open_scene.exit()
		open_scene = $PartyScene
		state = "party"
		$PartyScene.enter()

func _on_town_button_pressed() -> void:
	if state != "town":
		if open_scene:
			open_scene.exit()
		open_scene = $TownScene
		state = "town"
		$TownScene.enter()

func _on_save_pressed() -> void:
	PartyManager.save_characters()
	ResourceManager.save_file()
