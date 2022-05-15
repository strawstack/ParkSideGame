extends Node

# TODO

# Everything fades out to a grass field with two graves
# Grand appears above grave says dialogue
# GrandEvil appears "look out", but actally he's not harmful
# All three talk and the end is peaceful
# Player: "I still don't have a house again"
# GrandEvil: "We can build a new house with a little help from my friends" - ghost slide on screen
# Grand + all: Ha Ha Ha Ha...

# Credits

var textIndex = 0
var textList = [
	[ # 0 player
		"I started all this just to get a house...",
		"Now, I have no house and I'm back where I started."
	],
	[ # 1 grand
		["You're not back where you started...", "showGrand"],
		"You did what you could to save your great grandfather...",
		"And you did!"
	],
	[ # 2 player
		"Great grandfather was evil, but he at least he had a house."
	],
	[ # 3 evil
		["Nonsense!", "showGrandEvil"]
	],
	[ # 4 player and grand
		"Ah!"
	],
	[ # 5 evil
		"Don't be alarmed. I'm no threat anymore...",
		"I just came back to thank my great grandson for showing me how silly I was being...",
		"Thinking that a house could be more important than family...",
		"So, thank you great grandson, and you grandson for... saving me. I really mean that."
	],
	[ # 6 player
		"Thank you great grandfather...",
		"Well, now we have family, but no house."
	],
	[ # 7 evil
		["I think I have some friends that can help with that!", "enterGhosts"]
	],
	[ # 8 all
		"Ha Ha Ha Ha."
	]
]

var gc

func _ready():
	gc = get_tree().get_root().get_node("main")
	$TextBox.visible = false
	gc.toggleCanvasLayer(false)
	gc.setCurrentScene(self)
	$player.blockInput = true
	$player.scale = Vector2(1, 1)
	
	# debug
	_on_FadeInFromWhite_animation_finished("debug")

func showGrand():
	$showGrand.play("showGrand")

func showGrandEvil():
	$showEvil.play("showEvil")

func enterGhosts():
	$ghostEnter.play("ghostEnter")

func customCall(callName):
	call(callName)

func _on_FadeInFromWhite_animation_finished(anim_name):
	$TextBox.isActive = true
	$TextBox.visible = true
	nextSpeaker()

func nextSpeaker():
	$TextBox.showText(textList[textIndex])
	
func _on_TextBox_text_complete():
	textIndex += 1
	if textIndex < textList.size():
		nextSpeaker()
	else:
		gc.changeScene("res://levels/credits.tscn")

func _process(delta):
	$player_arrow.visible = false
	$grand_arrow.visible = false
	$evil_arrow.visible = false
	$player.scale = Vector2(1, 1)
	$Grand.scale = Vector2(1, 1)
	$GrandEvil.scale = Vector2(1, 1)
	if textIndex == 0 or textIndex == 2 or textIndex == 6:
		$player_arrow.visible = true
		$player.scale = Vector2(1.2, 1.2)
	elif textIndex == 1:
		$grand_arrow.visible = true
		$Grand.scale = Vector2(1.2, 1.2)
	elif textIndex == 3 or textIndex == 5 or textIndex == 7:
		$evil_arrow.visible = true
		$GrandEvil.scale = Vector2(1.2, 1.2)
	elif textIndex == 4:
		$player_arrow.visible = true
		$grand_arrow.visible = true
		$player.scale = Vector2(1.2, 1.2)
		$Grand.scale = Vector2(1.2, 1.2)
	elif textIndex == 8:
		$player_arrow.visible = true
		$grand_arrow.visible = true
		$evil_arrow.visible = true
		$player.scale = Vector2(1.2, 1.2)
		$Grand.scale = Vector2(1.2, 1.2)
		$GrandEvil.scale = Vector2(1.2, 1.2)
	else:
		$TextBox.visible = false
