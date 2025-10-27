extends Node

var dialog_panel: DialogPanel

func push_text(text: String) -> void:
	if dialog_panel:
		dialog_panel.push_text(" "+text)
	else:
		push_error("DialogPanel not found in scene tree")
