extends Node

export var tic_tac_toe_scene: PackedScene

func _on_TicTacToe_pressed():
	get_tree().change_scene_to(tic_tac_toe_scene)
	
