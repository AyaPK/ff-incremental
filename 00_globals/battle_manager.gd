extends Node

var battle_scene: BattleScene
var area_index: int = 0

var areas: Array[Dictionary] = [
	{ "name":"nearby_plains", "res":"res://areas/area_resources/nearby_plains.tres" },
	{ "name":"nearby_woods", "res":"res://areas/area_resources/nearby_woods.tres" }
]

func load_player() -> void:
	battle_scene.spawn_character()

func load_enemy(enemy_name: String) -> void:
	var enemy_resource: EnemyResource = EnemyIndex.load_resource(enemy_name)
	battle_scene.spawn_enemy(enemy_resource)

func damage_enemy(dmg: int) -> void:
	battle_scene.pause_timers()
	battle_scene.enemy_slot_1.hp -= dmg
	battle_scene.enemy_slot_1.show_damage(dmg)
	battle_scene.enemy_slot_1.hurt_animation.play("hurt")
	if battle_scene.enemy_slot_1.hp <= 0:
		battle_scene.enemy_slot_1.kill()
	battle_scene.start_timers()

func damage_character(dmg: int) -> void:
	battle_scene.pause_timers()
	battle_scene.character_slot_1.hurt_animation.play("hurt")
	battle_scene.character_slot_1.show_damage(dmg)
	battle_scene.character_slot_1.character.hp -= dmg
	battle_scene.refresh_stats()
	battle_scene.start_timers()

func get_area_name(index: int) -> String:
	return areas[index]["name"]

func get_area_resource(index: int) -> AreaResource:
	return load(areas[index]["res"])
