extends Node

var gc

var textIndex = 0
var textList = [
	[
		"Grandfather?...",
		"You passed away years ago. How is it possible that you are here?!"
	],
	[
		"Grandson, I'm speaking to you throught the spirit plane...",
		"I'm reaching out to you in your quest to buy a house."
	]
]

func _ready():
	gc = get_tree().get_root().get_node("main")
	gc.setWallMap($Walls)
	var text = "Exlore the garden"
	gc.setPlayerTask(1, text)
	gc.setPlayerTask(2, text)
	gc.toggleCanvasLayer(true)
	gc.setCurrentScene(self)

func nextSpeaker():
	$CanvasLayer/TextBox.showText(textList[textIndex])

func _on_Area2D_body_entered(body):
	$player.blockInput = true
	gc.toggleCanvasLayer(false)
	nextSpeaker()

func _on_TextBox_text_complete():
	textIndex += 1
	if textIndex < textList.size():
		nextSpeaker()
	else:
		$player.blockInput = true
		$CanvasLayer/TextBox.visible = false
