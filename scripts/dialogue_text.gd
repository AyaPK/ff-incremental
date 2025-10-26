class_name DialogueText extends Label

func _on_on_screen_screen_exited() -> void:
	self.queue_free()
