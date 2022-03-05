extends SceneTest

var scene: TicTacToeTestScene


func before_each():
	scene = load_scene("res://test/tic-tac-toe/TicTacToeTestScene.tscn")


func test_tictactoe():
	var grid = scene.grid_field
	assert_eq(grid.get_child_count(), 9)
	assert_false(scene.retry_button.visible, "Expect retry button to be invisible")
	assert_false(scene.winning_label.visible, "Expect winning label to be invisible")
	assert_string_contains(scene.player_turn.text, "Player X")

	var field: TextureButton = grid.get_child(0)
	field.emit_signal("pressed")
	assert_true(field.disabled, "Expect button to be disabled")
	
	assert_string_contains(scene.player_turn.text, "Player O")
	grid.get_child(1).emit_signal("pressed")
	
	assert_string_contains(scene.player_turn.text, "Player X")
	grid.get_child(4).emit_signal("pressed")
	
	assert_string_contains(scene.player_turn.text, "Player O")
	grid.get_child(2).emit_signal("pressed")
	
	assert_string_contains(scene.player_turn.text, "Player X")
	grid.get_child(8).emit_signal("pressed")
	
	assert_true(scene.retry_button.visible, "Expect retry button to be visible")
	assert_true(scene.winning_label.visible, "Expect winning label to be visible")
