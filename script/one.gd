extends Node

var gc

var ghostIndex = 0
var ghostList = [1]

func _ready():
	gc = get_tree().get_root().get_node("main")
	gc.setWallMap($Walls)
	gc.setPlayerTask(1, "Chase the ghost out of the room!")
	gc.setPlayerTask(2, "Chase the ghost out of the room!")
	gc.toggleCanvasLayer(true)

#func _process(delta):
#	pass
