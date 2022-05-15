extends Node

var gc

var textIndex = 0
var textList = [
	[
		"Hello again Grandson...",
		"I'm proud that you have made it this far...",
		"For I myself, made it no further."
	],
	[
		"So is this... your grave?"
	],
	[
		"Yes...",
		"You see your great grandfather didn't run out of this house...",
		"Your great grandfather BECAME this house...",
		"The land he bought was cursed, and when he set foot on it...",
		"He became the haunted mansion we are in right now!"
	],
	[
		"That's terrifying."
	],
	[
		"I died trying to free him, but I made it no further than this grave where I now rest...",
		"But you can go further, you can free his spirit from these walls...",
		"But be warned, the ghosts you've encountered so far were just toying with you...",
		"The rooms ahead are not so forgiving."
	],
	[
		"I've come this far. I won't look back now. You can count on me to free great grandfather!"
	],
	[
		"I wish you luck...",
		"Goodbye for now."
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
	$CanvasLayer/TextBox.visible = false
	$playerArrow.visible = false
	$grandArrow.visible = false

func nextSpeaker():
	$CanvasLayer/TextBox.showText(textList[textIndex])

func _on_Area2D_body_entered(body):
	$player.blockInput = true
	gc.toggleCanvasLayer(false)
	$playerArrow.set_position(Vector2($player.get_position().x, $playerArrow.get_position().y))
	$playerArrow.visible = true
	$CanvasLayer/TextBox.isActive = true
	toggleArrow()
	nextSpeaker()

func toggleArrow():
	$grandArrow.visible = $playerArrow.visible
	$playerArrow.visible = not $playerArrow.visible

func _on_TextBox_text_complete():
	textIndex += 1
	if textIndex < textList.size():
		toggleArrow()
		nextSpeaker()
	else:
		$TalkTrigger/Area2D.monitoring = false
		$player.blockInput = false
		$CanvasLayer/TextBox.visible = false
		$playerArrow.visible = false
		$grandArrow.visible = false
		$Grand.visible = false
		gc.toggleCanvasLayer(true)
		var text = "Exit at the top."
		gc.setPlayerTask(1, text)
		gc.setPlayerTask(2, text)
