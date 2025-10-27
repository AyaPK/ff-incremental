class_name DialogueText extends RichTextLabel

func _on_on_screen_screen_exited() -> void:
	self.queue_free()
