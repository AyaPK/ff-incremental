class_name DialogPanel extends Node2D

@onready var text_box: VBoxContainer = $Panel/SubViewportContainer/SubViewport/TextBox
const DIALOGUE_TEXT = preload("uid://co7uds00xf3xl")

func _ready() -> void:
	DialogueManager.dialog_panel = self

func push_text(text: String) -> void:
	var new_label: DialogueText = DIALOGUE_TEXT.instantiate()
	text_box.add_child(new_label)
	new_label.text = text
