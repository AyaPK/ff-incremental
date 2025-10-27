class_name StorePanel extends Node2D

var store_resource: Store

@onready var items_container: VFlowContainer = $ItemsContainer

const STORE_ITEM_PANEL = preload("uid://uvhxf8oyyjyw")


func load_store() -> void:
	for c in items_container.get_children():
		c.queue_free()
		await c.tree_exited
	for item in store_resource.buyables:
		var b: StoreItemPanel = STORE_ITEM_PANEL.instantiate()
		items_container.add_child(b)
		b.item_name.text = item.name
		b.item_cost.text = str(item.buy_price)+"gp"
		b.item = item
