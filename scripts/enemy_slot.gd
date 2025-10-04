class_name EnemySlot extends Sprite2D

var enemy_resource: EnemyResource

var max_hp: int
var hp: int
var enemy_name: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func process_resource() -> void:
	max_hp = enemy_resource.hp
	hp = max_hp
	enemy_name = enemy_resource.name
	texture = enemy_resource.image
	pass

func show_damage(num: int) -> void:
	var scn = load("res://scenes/damage_number.tscn")
	var damage_num: DamageNumber = scn.instantiate()
	damage_num.text = str(num)
	add_child(damage_num)
	
