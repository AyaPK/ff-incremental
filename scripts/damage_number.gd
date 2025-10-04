class_name DamageNumber extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$DamageNumberAnimation.play("hurt")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_damage_number_animation_animation_finished(_anim_name: StringName) -> void:
	queue_free()
