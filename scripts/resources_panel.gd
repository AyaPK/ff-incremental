extends PanelContainer

@onready var gp_amount: Label = $HBoxContainer/GP_Amount

func _ready() -> void:
	gp_amount.text = str(ResourceManager.gp)
	pass

func _process(_delta: float) -> void:
	refresh()

func refresh() -> void:
	gp_amount.text = str(ResourceManager.gp)
