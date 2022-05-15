extends Node

var textIndex = 0
var textList = [
	[
		"Is that you Great Grandfather?...",
		"I'm here to uh... save you?"
	],
	[
		"Ha Ha Ha Ha, foolish great grandson...",
		"I don't need saving...",
		"You're the one with no house... you're the one who needs saving...",
		"But don't worry, soon I'll have the largest house...",
		"And everyone will pay rent and live inside!"
	],
	[
		"I thought you were cursed and turned into this house...",
		"Do you need me to save you?"
	],
	[
		"I wasn't *turned into* this house...",
		"I chose to become this house...",
		"This house is huge. Who wouldn't want to become it!"
	],
	[
		"But... the ghosts... they attacked me?"
	],
	[
		"Sure there are a few ghosts here and there, but this basement apartment I'm building will bring in millions...",
		"I'll be rich. No one will care about a few ghosts then...",
		"In fact, you should rent this apartment... I'll give you a deal only 80% your income a month... plus utilities...",
		"Will you rent my apartment?"
	],
	[
		"Um, no thanks. I think I'll look at some other places."
	],
	[
		"Lies... there are no other places...",
		"You will rent this apartment, or I will throw you out onto the street!"
	],
	[
		"...",
		"No...",
		"I will find somewhere else that is AFFORDABLE!"
	],
	[
		"Then you leave me no choice."
	]
]

var gc

func _ready():
	gc = get_tree().get_root().get_node("main")
	$TextBox.visible = false

func nextSpeaker():
	if textIndex % 2 == 0:
		$DarkMask.set_position(Vector2($player.get_position().x, 80))
	else:
		$DarkMask.set_position(Vector2($EvilGrand.get_position().x, 24))
	$TextBox.showText(textList[textIndex])

func _on_Area2D_body_entered(body):
	$TextBox.isActive = true
	$TextBox.visible = true
	gc.toggleCanvasLayer(false)
	$player.blockInput = true
	$DarkMask.visible = true
	nextSpeaker()

func _on_TextBox_text_complete():
	textIndex += 1
	if textIndex < textList.size():
		nextSpeaker()
	else:
		$TextBox.visible = false
		gc.changeScene("res://levels/boss2.tscn")
