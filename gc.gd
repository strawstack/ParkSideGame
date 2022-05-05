extends Node

func _ready():
	pass
	
func getWallTileMap():
	return $wall

func _on_Area2D_body_entered(body):
	setPlayerTask(1, "Exit the room")
	setPlayerTask(2, "Exit the room")

func setPlayerTask(playerNumber, text):
	var label = null
	if playerNumber == 1:
		label = get_node("CanvasLayer/p1_container/task_text")
	else:
		label = $CanvasLayer/p2_container/task_text
	label.set_text(text)
