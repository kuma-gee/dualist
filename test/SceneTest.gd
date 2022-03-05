class_name SceneTest extends UnitTest


func load_scene(path: String):
	var scene = load(path)
	var instance = scene.instance()
	return add_child_autofree(instance)
