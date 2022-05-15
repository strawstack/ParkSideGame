extends Node

var textIndex = 0
var textList = [
	[
		"Well, you seem to be avoiding all my attacks...",
		"How could you move when frozen?...",
		"It's like there's two of you or something."
	],
	[
		"Give me the deed, so I can destroy it!"
	],
	[
		"This deed...",
		"It's far to precious to be destroyed...",
		"How about I destroy YOU instead?!"
	]
]

# TODO

# Show deed when GrandEvil refers to it
# At end of dialogue, fade in line of bad ghosts
# Advance slightly and stop
# Grand appears, says dialogue with highlight
# Grand kicks GrandEvil, Sacs to kill ghost
	# Says line of dialogue like "go get the deed" 
# Player can run to get the deed
# Deed rips on screen
# Flash white, then fade white, show scene
# Everything fades out to a grass field with two graves
# Grand appears above grave says dialogue
# GrandEvil appears "look out", but actally he's not harmful
# All three talk and the end is peaceful
# Player: "I still don't have a house again"
# GrandEvil: "We can build a new house with a little help from my friends" - ghost slide on screen
# Grand + all: Ha Ha Ha Ha...

# Credits

var gc

func _ready():
	gc = get_tree().get_root().get_node("main")
	$TextBox.visible = false
	gc.connect("fade_to_white_complete", self, "_fade_to_white_complete")
	
	# debug
	_fade_to_white_complete()

func _fade_to_white_complete():
	$TextBox.isActive = true
	$TextBox.visible = true
	gc.toggleCanvasLayer(false)
	$player.blockInput = true
	$DarkMask.visible = true
	nextSpeaker()

func nextSpeaker():
	if textIndex % 2 == 0:
		$DarkMask.set_position(Vector2($EvilGrand.get_position().x, 24))
	else:
		$DarkMask.set_position(Vector2($player.get_position().x, 80))
	$TextBox.showText(textList[textIndex])

func _on_TextBox_text_complete():
	textIndex += 1
	if textIndex < textList.size():
		nextSpeaker()
	else:
		$TextBox.visible = false
