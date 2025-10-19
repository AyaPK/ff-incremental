class_name ScenePanel extends Node2D

@export var scene_name: String

func exit() -> void:
	run_on_exit()
	hide()

func enter() -> void:
	run_on_enter()
	show()

func run_on_exit() -> void:
	pass

func run_on_enter() -> void:
	pass
