extends "res://addons/gut/test.gd"

var grid: GridContainer
var grid_values: GridValues

func _create_grid(col: int):
	grid = GridContainer.new()
	grid.columns = col

	for i in range(0, col):
		for j in range(0, col):
			grid.add_child(Button.new())

	grid_values = GridValues.new()

	add_child_autofree(grid)

	grid_values.grid_path = grid.get_path()
	add_child_autofree(grid_values)

	grid_values.load_grid()


func test_load_grid():
	_create_grid(2)
	assert_eq_deep(
		grid_values.values,
		[
			[false, false],
			[false, false],
		]
	)


func test_click_grid():
	_create_grid(2)
	grid.get_child(0).emit_signal("pressed")
	grid.get_child(2).emit_signal("pressed")

	assert_eq_deep(
		grid_values.values,
		[
			[true, false],
			[true, false],
		]
	)


func test_has_empty_values():
	_create_grid(2)
	grid_values.values = [
		[false, false],
		[false, false],
	]

	assert_eq(grid_values.has_nth_in_line(2), [])


func test_has_nth_in_row():
	_create_grid(2)
	grid_values.values = [
		[true, true],
		[false, false],
	]

	var actual = grid_values.has_nth_in_line(2)
	assert_eq(actual.size(), 2)
	assert_has(actual, Vector2(0, 0))
	assert_has(actual, Vector2(0, 1))


func test_has_nth_in_col():
	_create_grid(2)
	grid_values.values = [
		[true, false],
		[true, false],
	]

	var actual = grid_values.has_nth_in_line(2)
	assert_eq(actual.size(), 2)
	assert_has(actual, Vector2(0, 0))
	assert_has(actual, Vector2(1, 0))


func test_has_nth_in_diag_from_left():
	_create_grid(2)
	grid_values.values = [
		[true, false],
		[false, true],
	]

	var actual = grid_values.has_nth_in_line(2)
	assert_eq(actual.size(), 2)
	assert_has(actual, Vector2(0, 0))
	assert_has(actual, Vector2(1, 1))


func test_has_nth_in_diag_from_right():
	_create_grid(2)
	grid_values.values = [
		[false, true],
		[true, false],
	]

	var actual = grid_values.has_nth_in_line(2)
	assert_eq(actual.size(), 2)
	assert_has(actual, Vector2(1, 0))
	assert_has(actual, Vector2(0, 1))
