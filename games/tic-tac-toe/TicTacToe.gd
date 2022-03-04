extends Control

enum Player {
	X,
	O,
}

const FIELD_COUNT = 9
const FIELD_BUTTON = preload("res://games/tic-tac-toe/TicTacToeField.tscn")
const COLUMNS = 3

export var player_x_texture: Texture
export var player_o_texture: Texture

onready var grid := $VBoxContainer/MarginContainer/GridContainer
onready var grid_values := $GridValues
onready var player_turn_label := $VBoxContainer/CenterContainer/VBoxContainer/PlayerTurn
onready var winning_label := $VBoxContainer/CenterContainer/VBoxContainer/Winning

var current_player = Player.X

func _ready():
	for _i in range(0, FIELD_COUNT):
		var field_btn = FIELD_BUTTON.instance()
		grid.add_child(field_btn)
	
	_toggle_player_turn()
	grid_values.load_grid()


func _get_grid_item_by_index_vector(vec: Vector2) -> TextureButton:
	var grid_index = vec.x * COLUMNS + vec.y
	return grid.get_child(grid_index) as TextureButton


func _on_GridValues_grid_changed(idx):
	var btn = _get_grid_item_by_index_vector(idx)
	
	btn.disabled = true
	btn.texture_disabled = _get_player_texture()

	var line = grid_values.has_nth_in_line(COLUMNS)
	if line.size() > 0:
		_disable_all_grid_items()
		for item in line:
			var grid_item = _get_grid_item_by_index_vector(item)
			grid_item.modulate = Color.red
		
		winning_label.text = "You win"
	
	_toggle_player_turn()

func _toggle_player_turn():
	var is_player_X = current_player == Player.X
	current_player = Player.O if is_player_X else Player.X
	grid_values.fill_value = current_player
	
	var player_name = "X" if is_player_X else "O"
	player_turn_label.text = "Player %s" % player_name


func _disable_all_grid_items():
	for item in grid.get_children():
		item.disabled = true


func _get_player_texture() -> Texture:
	if current_player == Player.X:
		return player_x_texture
	return player_o_texture
