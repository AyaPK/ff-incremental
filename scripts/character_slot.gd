class_name CharacterSlot extends Sprite2D

@onready var move_timer: Timer = $MoveTimer
@onready var hurt_animation: AnimationPlayer = $HurtAnimation
@onready var char_anim: AnimationPlayer = $CharAnim

var character: Character
var timer_display: ProgressBar

func _ready() -> void:
	texture = character.image
	move_timer.wait_time = character.speed
	move_timer.start()
	pass

func _process(_delta: float) -> void:
	if timer_display:
		var elapsed = move_timer.wait_time - move_timer.time_left
		var percent = (elapsed / move_timer.wait_time) * 100
		timer_display.value = percent
	pass

func _on_move_timer_timeout() -> void:
	if BattleManager.battle_scene.enemy_slot_1 and !BattleManager.battle_scene.enemy_slot_1.dying:
		move_timer.stop()
		$Weapon.show()
		$Weapon/WeaponAnimation.play("attack")
		$CharAnim.play("attack")
		BattleManager.damage_enemy()
		await get_tree().create_timer(0.5).timeout
		move_timer.start()

func _on_char_anim_animation_finished(_anim_name: StringName) -> void:
	$Weapon.hide()
	$CharAnim.play("idle")

func show_damage(num: int) -> void:
	var scn = load("res://scenes/damage_number.tscn")
	var damage_num: DamageNumber = scn.instantiate()
	damage_num.text = str(num)
	add_child(damage_num)
