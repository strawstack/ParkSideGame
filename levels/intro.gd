extends Node

var textIndex = 0
var textList = [
	[
		"One one one...",
		"Two two two...",
		"Three Three Three...",
		"Four Four."
	],
	[
		"anotehr..",
		"character...",
		"speaks."
	]
]

var gc
func _ready():
	gc = get_tree().get_root().get_node("main")
	gc.connect("fade_to_white_complete", self, "_fade_to_white_complete")

func _process(delta):
	pass

func nextSpeaker():
	$TextBox.showText(textList[textIndex])

func _fade_to_white_complete():
	nextSpeaker()

func _on_TextBox_text_complete():
	textIndex += 1
	if textIndex < textList.size():
		nextSpeaker()
	else:
		gc.changeScene("res://levels/one.tscn")
