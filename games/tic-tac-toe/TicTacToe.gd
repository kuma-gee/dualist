extends Control

enum Player {
	X,
	O,
}

const FIELD_COUNT = 9
const FIELD_BUTTON = preload("res://games/tic-tac-toe/TicTacToeField.tscn")

export var player_x_texture: Texture
export var player_o_texture: Texture

onready var grid := $GridContainer
onready var grid_values := $GridValues

var current_player = Player.X

func _ready():
	for _i in range(0, FIELD_COUNT):
		var field_btn = FIELD_BUTTON.instance()
		field_btn.connect("pressed", self, "_on_field_btn_pressed", [field_btn])
		grid.add_child(field_btn)

func _on_field_btn_pressed(btn: TextureButton):
	btn.disabled = true
	btn.texture_disabled = _get_player_texture()
	current_player = Player.O if current_player == Player.X else Player.X

	# TODO: check winning


func _get_player_texture() -> Texture:
	if current_player == Player.X:
		return player_x_texture
	return player_o_texture
