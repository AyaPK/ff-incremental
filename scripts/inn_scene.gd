class_name InnScene extends ScenePanel

@onready var heal: Button = $Heal

var heal_cost: int
var heal_amount: int

func _ready() -> void:
	pass 

func _process(_delta: float) -> void:
	pass

func _on_heal_pressed() -> void:
	PartyManager.member_1.hp += heal_amount
	ResourceManager.gp -= heal_cost
	calculate_cost()

func calculate_cost() -> void:
	heal_amount = PartyManager.member_1.max_hp - PartyManager.member_1.hp
	heal_cost = heal_amount * 2
	
	if heal_cost > ResourceManager.gp:
		@warning_ignore("integer_division")
		heal_amount = floori(ResourceManager.gp/2)
		heal_cost = heal_amount * 2

	heal.text = "Stay the night \n ("+str(heal_cost)+"gp)"
