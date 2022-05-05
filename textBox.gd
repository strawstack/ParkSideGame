extends Node

var text = "Hey, thanks for taking my call. The house is full of ghosts. Can you get rid of them?"
var visibleChar = 0
var active = false

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and not active:
		active = true
		showText(text)

func showText(text):
	visibleChar = 0
	$CanvasLayer/Label.set_visible_characters(visibleChar)
	$CanvasLayer/Label.set_text(text)
	$CanvasLayer/Timer.start()

func _on_Timer_timeout():
	visibleChar += 1
	$CanvasLayer/Label.set_visible_characters(visibleChar)
	if visibleChar == text.length():
		$CanvasLayer/Timer.stop()
		active = false
	
