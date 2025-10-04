extends Node

var _index: Dictionary[String, String] = {
	"goblin": "res://enemies/normal/goblin.tres"
}

func load_resource(enemy_name: String) -> EnemyResource:
	var resource: EnemyResource = load(_index[enemy_name])
	return resource
