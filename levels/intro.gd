extends Node

var textIndex = 0
var textList = [
	[
		"Grandfather?...",
		"You passed away years ago. How is it possible that you are here?!"
	],
	[
		"Grandson, I'm speaking to you throught the spirit plane...",
		"I'm reaching out to you in your quest to buy a house."
	],
	[
		"Homes are so expensive these days!...",
		"Can you really help me find one? That would be amazing."
	],
	[
		"Yes, I can help you...",
		"In fact, I can help you find a house for free!"
	],
	[
		"FOR FREE! WOW!"
	],
	[
		"Our family has held the deed to a large mansion for generations...",
		"My great great grand-father purchased a plot of land hundreds of years ago...",
		"He planned to build a house on the empty land, but, when he arrived to the empty lot, he found a vast mansion was already there...",
		"When only the day before it had been empty."
	],
	[
		"A mansion, and you still have the deed, but why have you never mention this before?"
	],
	[
		"Because when my great great grand-father entered the house. He quickly found out it was haunted...",
		"It was full of ghosts. He dropped the deed on the floor as he ran out the door and never returned...",
		"But you have been as clever as two people since you were young...",
		"I bet you could rid the mansion of ghosts, find the deed, and obtain a place to live!"
	],
	[
		"Ghosts! A place to live! The market is so expensive right now...",
		"... Ok, I'll do it. I'll do it for my great great great grand-father, and for you!"
	],
	[
		"Thank you Grandson, good luck. Now, I must go...",
		"If you succeed, you can buy furniture at the Ikea...",
		"Good bye."
	],
	[
		"...Good bye."
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
