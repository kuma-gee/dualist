class_name TicTacToeTestScene extends Node

export var grid_field_path: NodePath
onready var grid_field: GridContainer = get_node(grid_field_path)

export var retry_button_path: NodePath
onready var retry_button: Button = get_node(retry_button_path)

export var player_turn_path: NodePath
onready var player_turn: Label = get_node(player_turn_path)

export var winning_label_path: NodePath
onready var winning_label: Label = get_node(winning_label_path)
