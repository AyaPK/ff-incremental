extends Node

var battle_scene: BattleScene

func load_player() -> void:
	battle_scene.spawn_character()

func load_enemy(enemy_name: String) -> void:
	var enemy_resource: EnemyResource = EnemyIndex.load_resource(enemy_name)
	battle_scene.spawn_enemy(enemy_resource)
