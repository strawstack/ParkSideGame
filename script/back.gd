extends Node

var gc

func _ready():
	gc = get_tree().get_root().get_node("main")
	$player.blockInput = true
	
func _on_Button_pressed():
	gc.changeScene("res://levels/mainMenu.tscn")
