class_name Equippable extends Item

@export_category("Compatibilities")
@export_flags("Fighter", "Black Mage", "Warrior") var compatible := 0
const FLAG_NAMES = ["Fighter", "Black Mage", "Warrior"]

func compatible_with(job_name: String) -> void:
	var bit_index = FLAG_NAMES.find(job_name)
	if bit_index == -1:
		return
	if compatible & (1 << bit_index):
		return

func is_equippable() -> void:
	pass
