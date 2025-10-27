extends Node

var battle_scene: BattleScene
var area_index: int = 0
var dead: bool = false

var town_index: int = 0

var areas: Array[Dictionary] = [
	{ "name":"nearby_plains", "res":"res://areas/area_resources/nearby_plains.tres"},
	{ "name":"nearby_woods", "res":"res://areas/area_resources/nearby_woods.tres" },
	{ "name":"chaos_forest", "res":"res://areas/area_resources/chaos_forest.tres" }
]

func load_player() -> void:
	battle_scene.spawn_character()

func load_enemy(enemy_name: String) -> void:
	var enemy_resource: EnemyResource = EnemyIndex.load_resource(enemy_name)
	battle_scene.spawn_enemy(enemy_resource)

func damage_enemy() -> void:
	var char_atk: int = battle_scene.character_slot_1.calculate_attack()
	var dmg: int = randi_range(char_atk, char_atk*2) - battle_scene.enemy_slot_1.defense
	dmg = clampi(dmg, 1, dmg)
	DialogueManager.push_text("The [color=SPRING_GREEN]"+battle_scene.character_slot_1.character.job.capitalize()+"[/color] attacks!")
	battle_scene.pause_timers()
	battle_scene.enemy_slot_1.hp -= dmg
	battle_scene.enemy_slot_1.show_damage(dmg)
	if battle_scene.enemy_slot_1.hp <= 0:
		battle_scene.enemy_slot_1.dying = true
	battle_scene.enemy_slot_1.hurt_animation.play("hurt")
	if battle_scene.enemy_slot_1.hp <= 0:
		battle_scene.enemy_slot_1.kill()
	battle_scene.start_timers()

func damage_character(dmg: int) -> void:
	battle_scene.pause_timers()
	DialogueManager.push_text("The [color=red]"+battle_scene.enemy_slot_1.enemy_name+"[/color] attacks!")
	battle_scene.character_slot_1.hurt_animation.play("hurt")
	battle_scene.character_slot_1.show_damage(dmg)
	battle_scene.character_slot_1.character.hp -= dmg
	battle_scene.refresh_stats()
	battle_scene.start_timers()
	
	if battle_scene.character_slot_1.character.hp <= 0:
		battle_scene.character_slot_1.character.dead = true
		party_wipe()

func get_area_name(index: int) -> String:
	return areas[index]["name"]

func get_area_resource(index: int) -> AreaResource:
	return load(areas[index]["res"])

func party_wipe() -> void:
	battle_scene.enemy_slot_1.queue_free()
	battle_scene.character_slot_1.character.hp = 0
	battle_scene.refresh_stats()
	dead = true
	battle_scene.character_slot_1.char_anim.play("down")
	while battle_scene.character_slot_1.character.hp < 5:
		await get_tree().create_timer(5).timeout
		battle_scene.character_slot_1.character.hp += 1
		battle_scene.refresh_stats()
	battle_scene.character_slot_1.char_anim.play("idle")
	dead = false
	battle_scene.character_slot_1.character.dead = false
