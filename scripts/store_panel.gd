class_name StorePanel extends Node2D

var store_resource: Store

@onready var items_container: VBoxContainer = $ItemsContainer

func load_store() -> void:
	print(store_resource)
	for c in items_container.get_children():
		c.queue_free()
		await c.tree_exited
	for item in store_resource.buyables:
		var b: Button = Button.new()
		b.text = item.name
		items_container.add_child(b)
		
