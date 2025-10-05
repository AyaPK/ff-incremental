class_name CharStatBar extends HBoxContainer

var character_slot: CharacterSlot

@onready var hp_amount: Label = $HP_amount
@onready var act_progress: ProgressBar = $ActProgress
@onready var hp_max: Label = $HP_max

func _ready() -> void:
	hp_amount.text = str(character_slot.character.hp)
	hp_max.text = str(character_slot.character.max_hp)
	character_slot.timer_display = act_progress
	pass

func _process(_delta: float) -> void:
	pass

func refresh_stats() -> void:
	hp_amount.text = str(character_slot.character.hp)
	hp_max.text = str(character_slot.character.max_hp)
