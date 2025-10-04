extends Node2D

func _ready() -> void:
	BattleManager.load_player()
	BattleManager.load_enemy("goblin")

func _process(_delta: float) -> void:
	pass
