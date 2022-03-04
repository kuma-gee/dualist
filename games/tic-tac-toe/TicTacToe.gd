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

onready var grid := $GridContainer
onready var grid_values := $GridValues

var current_player = Player.X

func _ready():
	for _i in range(0, FIELD_COUNT):
		var field_btn = FIELD_BUTTON.instance()
		grid.add_child(field_btn)
	
	grid_values.fill_value = current_player
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
		

	current_player = Player.O if current_player == Player.X else Player.X
	grid_values.fill_value = current_player


func _disable_all_grid_items():
	for item in grid.get_children():
		item.disabled = true


func _get_player_texture() -> Texture:
	if current_player == Player.X:
		return player_x_texture
	return player_o_texture
