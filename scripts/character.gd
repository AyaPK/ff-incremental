class_name Character extends Node

var job: String
var max_hp: int
var hp: int
var image: Texture2D

var level: int
var experience: int

var attack: int
var defense: int
var speed: float

var exp_table = [
	0, 28, 84, 196, 392, 700, 1148, 1764, 2576, 3612,
	4900, 6468, 8344, 10556, 13132, 16100, 19488, 23324, 27636, 32452,
	37800, 43708, 50204, 57316, 65072, 73500, 82628, 92484, 103096, 114492,
	126700, 139748, 153664, 168476, 184212, 200900, 218568, 237244, 256956, 277732,
	299600, 322588, 346724, 372036, 398552, 426300, 455300, 484299, 513299, 542298,
	571298, 600297, 629297, 658296, 687296, 716295, 745295, 774294, 803294, 832293,
	861293, 890292, 919292, 948291, 977291, 1006290, 1035290, 1064289, 1093289, 1122288,
	1151288, 1180287, 1209287, 1238286, 1267286, 1296285, 1325285, 1354284, 1383284, 1412283,
	1441283, 1470282, 1499282, 1528281, 1557281, 1586280, 1615280, 1644279, 1673279, 1702278,
	1731278, 1760277, 1789277, 1818276, 1847276, 1876275, 1905275, 1934274, 1963274
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func get_exp_for_level(l: int) -> int:
	if l < 1 or l > exp_table.size():
		return 999999999 # cap at max level
	return exp_table[l - 1]

func add_experience(amount: int) -> void:
	experience += amount
	_check_level_up()

func _check_level_up() -> void:
	while level < exp_table.size() and experience >= get_exp_for_level(level + 1):
		level += 1
		_level_up()
		BattleManager.battle_scene.refresh_stats()

func _level_up() -> void:
	max_hp += randi_range(3, 8)
	if job == "warrior":
		attack += 1
		defense += 1
