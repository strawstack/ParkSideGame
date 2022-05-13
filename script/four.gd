extends Node

var gc

func _ready():
	gc = get_tree().get_root().get_node("main")
	gc.setWallMap($Walls)
	gc.setPlayerTask(1, "Chase the ghosts.")
	gc.setPlayerTask(2, "Avoid the lava!")
	gc.toggleCanvasLayer(true)
	gc.setCurrentScene(self)

func playerDies():
	gc.changeScene("res://levels/four.tscn")

func playerBlock(value):
	$player.blockInput = value
