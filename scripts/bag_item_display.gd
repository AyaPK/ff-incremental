class_name BagItemDisplay extends PanelContainer

var item: Item
var bag: BagPanel
var bag_index: int

@onready var image: TextureRect = $VBoxContainer/image
@onready var item_name: Label = $VBoxContainer/Name
@onready var usage_button: Button = $VBoxContainer/UsageButton

func _ready() -> void:
	if item:
		image.texture = item.sprite
		item_name.text = item.name
		self_modulate = ResourceManager.rarity_colours[item.rarities]
		
		if item.has_method("is_mainhand"):
			usage_button.text = "Equip"

func _on_sell_button_pressed() -> void:
	ResourceManager.inventory.remove_at(bag_index)
	ResourceManager.gp += item.sell_price
	bag.show_items()
	DialogueManager.push_text("Sold "+item.coloured_name+" for "+str(item.buy_price)+" gp!")


func _on_equip_button_pressed() -> void:
	if item.has_method("is_mainhand"):
		ResourceManager.inventory.remove_at(bag_index)
		if PartyManager.member_1.main_hand:
			ResourceManager.inventory.append(PartyManager.member_1.main_hand)
		PartyManager.member_1.main_hand = item
	bag.show_items()
