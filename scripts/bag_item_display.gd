class_name BagItemDisplay extends PanelContainer

var item: Item

@onready var image: TextureRect = $image

func _ready() -> void:
	if item:
		image.texture = item.sprite
