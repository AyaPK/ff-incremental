class_name StoreItemPanel extends PanelContainer

@onready var item_name: Label = $StoreItemHbox/ItemName
@onready var item_cost: Label = $StoreItemHbox/ItemCost

var item: Item

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_buy_button_pressed() -> void:
	if ResourceManager.gp >= item.buy_price:
		ResourceManager.gp -= item.buy_price
		ResourceManager.inventory.append(item)
		DialogueManager.push_text("Bought "+item.name+"!")
