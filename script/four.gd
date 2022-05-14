extends Node

var gc

var ghostIndex = 0
var ghostList = ["1", "2", "3"]

func _ready():
	gc = get_tree().get_root().get_node("main")
	gc.setWallMap($Walls)
	gc.setPlayerTask(1, "Chase green ghosts in order.")
	gc.setPlayerTask(2, "Avoid lava and red ghosts!")
	gc.toggleCanvasLayer(true)
	gc.setCurrentScene(self)

func nextGhost(ghostSymbol):
	if ghostList[ghostIndex] != ghostSymbol:
		ghostIndex = 0
		$MoveGhost.visible = true
		$MoveGhost/Body/GhostArea2D.set_monitoring(true)
		$MoveGhost2.visible = true
		$MoveGhost2/Body/GhostArea2D.set_monitoring(true)
		$MoveGhost3.visible = true
		$MoveGhost3/Body/GhostArea2D.set_monitoring(true)
		return false
	
	ghostIndex += 1
	
	if ghostIndex == ghostList.size():
		sceneComplete()
	
	return true

func playerDies():
	gc.changeScene("res://levels/four.tscn")

func sceneComplete():
	# Remove doors
	$Walls.set_cell(5, 2, -1)
	$Walls.set_cell(5, 3, -1)
	$PurpleWalls.set_cell(5, 2, -1)
	$PurpleWalls.set_cell(5, 3, -1)
	var text = "Exit through the wall."
	gc.setPlayerTask(1, text)
	gc.setPlayerTask(2, text)

func playerBlock(value):
	$player.blockInput = value
