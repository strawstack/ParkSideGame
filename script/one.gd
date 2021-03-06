extends Node

var gc

var ghostIndex = 0
var ghostList = ["1"]

func _ready():
	gc = get_tree().get_root().get_node("main")
	gc.setWallMap($Walls)
	var text = "Chase the ghost out of the room!"
	gc.setPlayerTask(1, text)
	gc.setPlayerTask(2, text)
	gc.toggleCanvasLayer(true)
	gc.setCurrentScene(self)

func nextGhost(ghostSymbol):
	if ghostList[ghostIndex] != ghostSymbol:
		# Consider reset of all progress on wrong interaction
		return false
	
	ghostIndex += 1
	
	if ghostIndex == ghostList.size():
		sceneComplete() 
	
	return true

func sceneComplete():
	# Remove doors
	$Walls.set_cell(10, 0, -1)
	$Walls.set_cell(11, 0, -1)
	var text = "Exit through the door at the top."
	gc.setPlayerTask(1, text)
	gc.setPlayerTask(2, text)
	$Doors.visible = false
