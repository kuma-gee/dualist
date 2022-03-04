class_name UnitTest extends "res://addons/gut/test.gd"


func assert_contains_exact(actual: Array, expected: Array):
	assert_eq(actual.size(), expected.size())
	for item in expected:
		assert_has(actual, item)
