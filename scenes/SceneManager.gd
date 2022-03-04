extends Node

export var main_scene: PackedScene

func to_main_menu():
	get_tree().change_scene_to(main_scene)
