extends Node

var gc

var ghostIndex = 0
var ghostList = ["1"]

func _ready():
	gc = get_tree().get_root().get_node("main")
	gc.setWallMap($Walls)
	gc.setPlayerTask(1, "Avoid the red ghosts.")
	gc.setPlayerTask(2, "Chase the green ghost!")
	gc.toggleCanvasLayer(true)
	gc.setCurrentScene(self)

func nextGhost(ghostSymbol):
	sceneComplete()
	return true

func playerDies():
	gc.changeScene("res://levels/five.tscn")

func sceneComplete():
	# Remove doors
	$Walls.set_cell(11, 0, -1)
	$Walls.set_cell(12, 0, -1)
	$PurpleWalls.set_cell(11, 0, -1)
	$PurpleWalls.set_cell(12, 0, -1)
	var text = "Exit through the wall."
	gc.setPlayerTask(1, text)
	gc.setPlayerTask(2, text)

func playerBlock(value):
	$player.blockInput = value
