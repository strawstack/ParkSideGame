extends Node

var gc

func _ready():
	gc = get_tree().get_root().get_node("main")
	gc.setWallMap($Walls)
	gc.setPlayerTask(1, "Explore the pool area.")
	gc.setPlayerTask(2, "Explore the pool area.")
	gc.toggleCanvasLayer(true)
	gc.setCurrentScene(self)
