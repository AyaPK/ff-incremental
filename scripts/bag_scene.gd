class_name BagPanel extends ScenePanel

const BAG_ITEM_DISPLAY = preload("uid://b0eovaumvtjr2")

@onready var bag_panel: HFlowContainer = %BagPanel
@onready var panel_name: Label = $TextureRect2/PanelName

func run_on_enter() -> void:
	show_weapons()
	show()

func run_on_exit() -> void:
	hide()

func show_items() -> void:
	if panel_name.text == "Weapons":
		show_weapons()

func show_weapons() -> void:
	clear_items()
	panel_name.text = "Weapons"
	var weapons: Array[Equippable] = ResourceManager.get_all_weapons()
	for x in range(weapons.size()):
		var item: Item = weapons[x]
		var panel: BagItemDisplay = BAG_ITEM_DISPLAY.instantiate()
		panel.item = item
		panel.bag = self
		panel.bag_index = x
		bag_panel.add_child(panel)
	
func clear_items() -> void:
	panel_name.text = ""
	for c in bag_panel.get_children():
		c.queue_free()
		await c.tree_exited

func _on_weapons_button_pressed() -> void:
	show_weapons()

func _on_armour_button_pressed() -> void:
	clear_items()

func _on_consumables_button_pressed() -> void:
	clear_items()

func _on_key_items_button_pressed() -> void:
	clear_items()
