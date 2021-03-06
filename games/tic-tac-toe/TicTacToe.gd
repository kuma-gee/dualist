extends Control

enum Player {
	X,
	O,
}

const FIELD_COUNT = 9
const FIELD_BUTTON = preload("res://games/tic-tac-toe/TicTacToeField.tscn")
const COLUMNS = 3

export var player_turn_label_path: NodePath
onready var player_turn_label: Label = get_node(player_turn_label_path)

export var winning_label_path: NodePath
onready var winning_label: Label = get_node(winning_label_path)

export var win_overlay_path: NodePath
onready var win_overlay: Control = get_node(win_overlay_path)

onready var grid := $VBoxContainer/MarginContainer/GridContainer
onready var grid_values := $GridValues

var current_player: int = -1

func _ready():
	_create_new_game()


func _create_new_game():
	for child in grid.get_children():
		grid.remove_child(child)
	
	for _i in range(0, FIELD_COUNT):
		var field_btn = FIELD_BUTTON.instance()
		grid.add_child(field_btn)
	
	win_overlay.hide()
	_toggle_player_turn()
	grid_values.load_grid()


func _get_grid_item_by_index_vector(vec: Vector2) -> Button:
	var grid_index = vec.x * COLUMNS + vec.y
	return grid.get_child(grid_index) as Button


func _on_GridValues_grid_changed(idx):
	var btn = _get_grid_item_by_index_vector(idx)
	
	btn.disabled = true
	btn.text = _get_player_text()

	var line = grid_values.has_nth_in_line(COLUMNS)
	if line.size() > 0:
		_disable_all_grid_items()
		for item in line:
			var grid_item = _get_grid_item_by_index_vector(item)
			grid_item.modulate = Color.red
		
		winning_label.text = player_turn_label.text + " wins!"
		win_overlay.show()
	
	_toggle_player_turn()


func _toggle_player_turn():
	current_player = Player.O if current_player == Player.X else Player.X
	grid_values.fill_value = current_player
	player_turn_label.text = "Player %s" % _get_player_text()


func _get_player_text() -> String:
	return "X" if current_player == Player.X else "O"


func _disable_all_grid_items():
	for item in grid.get_children():
		item.disabled = true


func _on_Retry_pressed():
	_create_new_game()


func _on_BackMenu_pressed():
	SceneManager.to_main_menu()
