class_name BagPanel extends ScenePanel

const BAG_ITEM_DISPLAY = preload("uid://b0eovaumvtjr2")

@onready var bag_panel: HFlowContainer = $Panel/BagPanel

func run_on_enter() -> void:
	show_items()
	show()

func run_on_exit() -> void:
	hide()

func show_items() -> void:
	clear_items()
	for x in range(ResourceManager.inventory.size()):
		var item: Item = ResourceManager.inventory[x]
		var panel: BagItemDisplay = BAG_ITEM_DISPLAY.instantiate()
		panel.item = item
		panel.bag = self
		panel.bag_index = x
		bag_panel.add_child(panel)

	
func clear_items() -> void:
	for c in bag_panel.get_children():
		c.queue_free()
		await c.tree_exited
