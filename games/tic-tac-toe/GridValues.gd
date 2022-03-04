class_name GridValues extends Node

signal grid_changed(idx)

export var grid_path: NodePath
onready var grid: GridContainer = get_node(grid_path)

var values = []
var fill_value = true


func load_grid():
	values = []

	var columns = grid.columns
	var row = []
	for idx in range(0, grid.get_child_count()):
		var child = grid.get_child(idx)
		child.connect("pressed", self, "_on_grid_pressed", [idx])
		row.append(null)

		if idx % columns == columns - 1:
			values.append(row)
			row = []


func _on_grid_pressed(idx: int) -> void:
	var row = int(idx / grid.columns)
	var col = idx % grid.columns

	values[row][col] = fill_value if values[row][col] == null else null
	emit_signal("grid_changed", Vector2(row, col))


func has_nth_in_line(count: int) -> Array:
	var size = values.size()
	var consecutiveValues = 0

	# Assuming it's always a valid grid
	for row_idx in range(0, size):
		consecutiveValues = 0
		for col_idx in range(0, size):
			var value = values[row_idx][col_idx]

			if value == fill_value:
				consecutiveValues += 1
			else:
				consecutiveValues = 0

			if consecutiveValues >= count:
				var result = []
				var start_idx = col_idx - count + 1
				for i in range(0, count):
					result.append(Vector2(row_idx, start_idx + i))

				print("Match by row")
				return result

	for col_idx in range(0, size):
		consecutiveValues = 0
		for row_idx in range(0, size):
			var value = values[row_idx][col_idx]

			if value == fill_value:
				consecutiveValues += 1
			else:
				consecutiveValues = 0

			if consecutiveValues >= count:
				var result = []
				var start_idx = row_idx - count + 1
				for i in range(0, count):
					result.append(Vector2(start_idx + i, col_idx))

				print("Match by column")
				return result

	for top_idx in range(0, size):
		var col_idx = top_idx
		var row_idx = 0
		consecutiveValues = 0

		while row_idx < size and col_idx < size:
			var value = values[row_idx][col_idx]
			if value == fill_value:
				consecutiveValues += 1
			else:
				consecutiveValues = 0

			if consecutiveValues >= count:
				var result = []
				var start_row_idx = row_idx - count + 1
				var start_col_idx = col_idx - count + 1
				for i in range(0, count):
					result.append(Vector2(start_row_idx + i, start_col_idx + i))

				print("Match by diagonal from left")
				return result

			col_idx += 1
			row_idx += 1

	var max_idx = size - 1
	for top_idx in range(max_idx, -1, -1):
		var col_idx = top_idx
		var row_idx = 0
		consecutiveValues = 0

		while row_idx < size and col_idx >= 0:
			var value = values[row_idx][col_idx]
			if value == fill_value:
				consecutiveValues += 1
			else:
				consecutiveValues = 0

			if consecutiveValues >= count:
				var result = []
				var start_row_idx = row_idx
				var start_col_idx = col_idx
				for i in range(0, count):
					result.append(Vector2(start_row_idx - i, start_col_idx + i))

				print("Match by diagonal from right")
				return result

			col_idx -= 1
			row_idx += 1

	return []


func _empty(line: Array) -> bool:
	for value in line:
		if value:
			return false
	return true
