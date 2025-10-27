class_name DialogueText extends RichTextLabel

func _on_on_screen_screen_exited() -> void:
	self.queue_free()

func _ready() -> void:
	visible_characters = 0

func _physics_process(delta: float) -> void:
	visible_characters += 2
