extends Node

var gc

var ghostIndex = 0
var ghostList = ["1", "2", "3", "4"]

func _ready():
	gc = get_tree().get_root().get_node("main")
	gc.setWallMap($Walls)
	gc.setPlayerTask(1, "Avoid the ghosts.")
	gc.setPlayerTask(2, "Avoid the ghosts.")
	gc.toggleCanvasLayer(true)
	gc.setCurrentScene(self)
	gc.connect("fade_to_white_complete", self, "_fade_to_white_complete")

func _fade_to_white_complete():
	$Timer.start()

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
	gc.changeScene("res://levels/boss2.tscn")

func sceneComplete():
	gc.changeScene("res://levels/boss3.tscn")

func playerBlock(value):
	$player.blockInput = value

func _on_Timer_timeout():
	$badVert.play("badVertDown")

func _on_badVert_animation_finished(anim_name):
	if anim_name == "badVertDown":
		$badSide.play("badSideAcross")
	elif anim_name == "badVertUp":
		$badSide.play("badSideBack")
	
func _on_badSide_animation_finished(anim_name):
	if anim_name == "badSideAcross":
		$badVert.play("badVertUp")
	elif anim_name == "badSideBack":
		$badVert.play("badVertDown")
