extends Node

var gc

var ghostIndex = 0
var ghostList = ["1", "2", "3"]

func _ready():
	gc = get_tree().get_root().get_node("main")
	gc.setWallMap($Walls)
	var text = "Chase the ghosts in order."
	gc.setPlayerTask(1, text)
	gc.setPlayerTask(2, text)
	gc.toggleCanvasLayer(true)
	gc.setCurrentScene(self)

func nextGhost(ghostSymbol):
	if ghostList[ghostIndex] != ghostSymbol:
		ghostIndex = 0
		$Ghost.visible = true
		$Ghost/GhostArea2D.set_monitoring(true)
		$Ghost2.visible = true
		$Ghost2/GhostArea2D.set_monitoring(true)
		$Ghost3.visible = true
		$Ghost3/GhostArea2D.set_monitoring(true)
		return false
	
	ghostIndex += 1
	
	if ghostIndex == ghostList.size():
		sceneComplete()
	
	return true

func sceneComplete():
	# Remove doors
	$Walls.set_cell(7, 0, -1)
	$Walls.set_cell(8, 0, -1)
	var text = "Exit through the door."
	gc.setPlayerTask(1, text)
	gc.setPlayerTask(2, text)
	$Doors.visible = false
