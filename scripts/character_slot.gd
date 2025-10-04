class_name CharacterSlot extends Sprite2D

var character: Character

func _ready() -> void:
	texture = character.image
	pass

func _process(_delta: float) -> void:
	pass
