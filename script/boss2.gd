extends Node

var gc

var ghostIndex = 0
var ghostList = ["1", "2", "3", "4"]

var isEnding = false

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
		$Ghost.visible = true
		$Ghost/GhostArea2D.set_monitoring(true)
		$Ghost2.visible = true
		$Ghost2/GhostArea2D.set_monitoring(true)
		$Ghost3.visible = true
		$Ghost3/GhostArea2D.set_monitoring(true)
		$Ghost4.visible = true
		$Ghost4/GhostArea2D.set_monitoring(true)
		return false
	
	ghostIndex += 1
	
	if ghostIndex == ghostList.size():
		isEnding = true
		sceneComplete()
	
	return true

func playerDies():
	if not isEnding:
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
