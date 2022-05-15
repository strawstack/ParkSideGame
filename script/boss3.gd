extends Node

var gc

var ghostIndex = 0
var ghostList = ["1", "2", "3", "4"]

var ghostNodeList
var ghostAreaList

func _ready():
	gc = get_tree().get_root().get_node("main")
	gc.setWallMap($Walls)
	gc.setPlayerTask(1, "Avoid the ghosts.")
	gc.setPlayerTask(2, "Avoid the ghosts.")
	gc.toggleCanvasLayer(true)
	gc.setCurrentScene(self)
	gc.connect("fade_to_white_complete", self, "_fade_to_white_complete")
	gc.showArrow_p1(false)
	gc.showArrow_p2(false)
	ghostNodeList = [$Ghost, $Ghost2, $Ghost3, $Ghost4]
	ghostAreaList = [$Ghost/GhostArea2D, $Ghost2/GhostArea2D, $Ghost3/GhostArea2D, $Ghost4/GhostArea2D]

func _fade_to_white_complete():
	$Timer.start()

func nextGhost(ghostSymbol):
	if ghostList[ghostIndex] != ghostSymbol:
		ghostIndex = 0
		for ghost in ghostNodeList:
			ghost.visible = true
		for ghost in ghostAreaList:
			ghost.set_monitoring(true)
		return false
	
	ghostIndex += 1
	
	if ghostIndex == ghostList.size():
		sceneComplete()
	
	return true

func playerDies():
	gc.changeScene("res://levels/boss3.tscn")

func sceneComplete():
	gc.showArrow_p1(false)
	gc.showArrow_p2(false)
	gc.changeScene("res://levels/boss4.tscn")

func playerBlock(value):
	$player.blockInput = value

func _on_Timer_timeout():
	$badVert.play("badVertDown")
	gc.setPlayerTask(2, "Avoid the ghosts.")
	$player.blockList.left = false
	$player.blockList.right = false
	gc.showArrow_p1(true)
	gc.setPlayerTask(1, "YOU ARE FROZEN!!")
	$player.blockList.up = true
	$player.blockList.down = true

func _on_badVert_animation_finished(anim_name):
	if anim_name == "badVertDown":
		$badSide.play("badSideAcross")
		gc.showArrow_p1(false)
		gc.setPlayerTask(1, "Avoid the ghosts.")
		$player.blockList.up = false
		$player.blockList.down = false
		gc.showArrow_p2(true)
		gc.setPlayerTask(2, "YOU ARE FROZEN!!")
		$player.blockList.left = true
		$player.blockList.right = true
	elif anim_name == "badVertUp":
		$badSide.play("badSideBack")
		gc.showArrow_p1(false)
		gc.setPlayerTask(1, "Avoid the ghosts.")
		$player.blockList.up = false
		$player.blockList.down = false
		gc.showArrow_p2(true)
		gc.setPlayerTask(2, "YOU ARE FROZEN!!")
		$player.blockList.left = true
		$player.blockList.right = true
	
func _on_badSide_animation_finished(anim_name):
	if anim_name == "badSideAcross":
		$badVert.play("badVertUp")
		gc.showArrow_p2(false)
		gc.setPlayerTask(2, "Avoid the ghosts.")
		$player.blockList.left = false
		$player.blockList.right = false
		gc.showArrow_p1(true)
		gc.setPlayerTask(1, "YOU ARE FROZEN!!")
		$player.blockList.up = true
		$player.blockList.down = true
	elif anim_name == "badSideBack":
		$badVert.play("badVertDown")
		gc.showArrow_p2(false)
		gc.setPlayerTask(2, "Avoid the ghosts.")
		$player.blockList.left = false
		$player.blockList.right = false
		gc.showArrow_p1(true)
		gc.setPlayerTask(1, "YOU ARE FROZEN!!")
		$player.blockList.up = true
		$player.blockList.down = true
