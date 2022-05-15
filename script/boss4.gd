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
		["This deed...", "showDeed"],
		"It's far to precious to be destroyed...",
		["How about I destroy YOU instead?!", "badGhostForward"]
	],
	[
		["Wait! Grandson...", "grandFlyIn"],
		"Grandson, I was wrong...",
		"As you know by now, your Great Grandfather is clearly evil!...",
		"Destroy the deed... That's the only way to end his madness."
	],
	[
		"But, if I destroy the deed, I'll destroy the house...",
		"No! Even though I'll lose the house. The deed must be destroyed!"
	],
	[
		["Now! Get to the deed!", "grandSac"]
	],
	[
		"Ah! Grandfather sacrificed himself. Now, I can reach the deed."
	]
]

var gc

var shakeOn = false

func _ready():
	gc = get_tree().get_root().get_node("main")
	$TextBox.visible = false
	gc.connect("fade_to_white_complete", self, "_fade_to_white_complete")
	gc.setWallMap($Walls)
	gc.toggleCanvasLayer(false)
	gc.setCurrentScene(self)
	$YSort/player.blockInput = true

func _fade_to_white_complete():
	$TextBox.isActive = true
	$TextBox.visible = true
	gc.toggleCanvasLayer(false)
	$YSort/player.blockInput = true
	$DarkMask.visible = true
	nextSpeaker()

func showDeed():
	$DeedBob.play("DeedBob")
	$DeedAppear.play("DeedAppear")

func badGhostForward():
	$BadGhostForward.play("BadGhostForward")

func grandFlyIn():
	$GrandEnter.play("GrandEnter")

func nextGhost(ghostSymbol):
	return true

func grandSac():
	$GrandSac.play("GrandSac")
	$FadeGhostTimer.start()

func customCall(callName):
	call(callName)

func nextSpeaker():
	$TextBox.showText(textList[textIndex])

func _process(delta):
	if textIndex == 3 or textIndex == 5:
		$DarkMask.set_position($Grand.get_position())
	elif textIndex % 2 == 1 or textIndex == 4 or textIndex == 6:
		$DarkMask.set_position($YSort/player.get_position() + Vector2(0, -8))
	else:
		$DarkMask.set_position(Vector2($EvilGrand.get_position().x, 24))

func _on_TextBox_text_complete():
	textIndex += 1
	if textIndex < textList.size():
		nextSpeaker()
	else:
		$TextBox.visible = false
		$YSort/player.blockInput = false
		$DarkMask.visible = false
		gc.setPlayerTask(1, "Destroy the deed.")
		gc.setPlayerTask(2, "Destroy the deed.")
		gc.toggleCanvasLayer(true)

func _on_FadeGhostTimer_timeout():
	$FadeGhosts.play("FadeGhosts")

func showDeedCut():
	$deedCut.visible = true
	$DeedCutScene.play("DeedCutScene")

func hideDeed():
	$deedCut/deed.visible = false

func _on_Area2D_body_entered(body):
	if body.name == "player":
		$YSort/player.blockInput = true
		$FlashWhite.play("FlashWhite")
		gc.toggleCanvasLayer(false)

func _on_DeedCutScene_animation_finished(anim_name):
	$TextBox.visible = false
	$TextBox2.visible = true
	$DarkMask2.visible = true
	$deedCut.visible = false
	$Deed.visible = false
	$ShakeTimer.start()
	$FadeWhite.play("FadeWhite")

func _on_ShakeTimer_timeout():
	var cam = $Camera2D
	if shakeOn:
		cam.set_h_offset(0)
	else:
		cam.set_h_offset(0.3)
	shakeOn = not shakeOn

func _on_FadeWhite_animation_finished(anim_name):
	gc.changeScene("res://levels/outro.tscn", true)
