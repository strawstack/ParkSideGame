extends Node2D

export (String) var sceneName

var gc

func _ready():
	gc = get_tree().get_root().get_node("main")

func warp():
	gc.changeScene(sceneName)

func _on_Area1_body_entered(body):
	if body.name == "player":
		warp()

func _on_Area2_body_entered(body):
	if body.name == "player":
		warp()
