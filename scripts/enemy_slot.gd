class_name EnemySlot extends Sprite2D

var enemy_resource: EnemyResource

var max_hp: int
var hp: int
var attack: int
var defense: int
var enemy_name: String
var dying = false

@onready var hurt_animation: AnimationPlayer = $HurtAnimation
@onready var move_timer: Timer = $MoveTimer

func _ready() -> void:
	process_resource()
	pass

func _process(_delta: float) -> void:
	pass

func process_resource() -> void:
	max_hp = enemy_resource.hp
	hp = max_hp
	attack = enemy_resource.attack
	defense = enemy_resource.defense
	enemy_name = enemy_resource.name
	texture = enemy_resource.image
	move_timer.wait_time = enemy_resource.speed
	pass

func show_damage(num: int) -> void:
	var scn = load("res://scenes/damage_number.tscn")
	var damage_num: DamageNumber = scn.instantiate()
	damage_num.text = str(num)
	add_child(damage_num)
	
func kill() -> void:
	await hurt_animation.animation_finished
	material = null
	hurt_animation.play("die")
	dying = true
	await hurt_animation.animation_finished
	ResourceManager.gp += enemy_resource.gp_drop
	PartyManager.member_1.add_experience(enemy_resource.exp_drop)
	DialogueManager.push_text("The [color=red]"+enemy_name+"[/color] was defeated!")
	queue_free()

func _on_move_timer_timeout() -> void:
	if !dying:
		$AttackAnimation.play("attack")
		BattleManager.damage_character(2)
