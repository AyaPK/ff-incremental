class_name PartyPanel extends PanelContainer

var character: Character
@onready var anim: AnimationPlayer = $VBoxContainer/PanelContainer/AnimationPlayer

@onready var job_name: Label = $VBoxContainer/JobName
@onready var image: Sprite2D = $VBoxContainer/PanelContainer/Picture
@onready var hp_number: Label = $VBoxContainer/HP/Number
@onready var atk_number: Label = $VBoxContainer/Attack/Number
@onready var def_number: Label = $VBoxContainer/Defense/Number
@onready var spd_number: Label = $VBoxContainer/Speed/Number
@onready var lvl_number: Label = $VBoxContainer/Level/Number

func show_party_member() -> void:
	if character:
		job_name.text = character.job.to_upper()
		lvl_number.text = str(character.level)
		image.texture = character.image
		hp_number.text = str(character.hp)+"/"+str(character.max_hp)
		atk_number.text = str(character.attack)
		def_number.text = str(character.defense)
		spd_number.text = str(character.speed)
		if character.dead:
			anim.play("down")
		else:
			anim.play("default")
	else:
		lvl_number.text = ""
		image.texture = null
		hp_number.text = ""
		atk_number.text = ""
		def_number.text = ""
		spd_number.text = ""
