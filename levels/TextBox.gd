extends Control

# List of sentences and current index
var textList
var textListIndex

# Number of characters visible
var charVisible

var isAnimating

signal text_complete

func _ready():
	$nextLabel.visible = false
	visible = false
	isAnimating = false
	

func showText(_textList):
	if isAnimating == false:
		textList = _textList
		textListIndex = 0
		$Label.set_text(textList[textListIndex])
		charVisible = 0
		$Label.set_visible_characters(charVisible)
		visible = true
		isAnimating = true
		$CharacterTimer.start()

func nextSentance():
	textListIndex += 1
	if textListIndex >= textList.size():
		emit_signal("text_complete")
	else:
		$Label.set_text(textList[textListIndex])
		charVisible = 0
		$Label.set_visible_characters(charVisible)
		isAnimating = true
		$CharacterTimer.start()

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if isAnimating:
			$CharacterTimer.stop()
			isAnimating = false
			charVisible = textList[textListIndex].size()
			$Label.set_visible_characters(charVisible)
			promtNext()
		else:
			# display all characters
			$nextLabel.visible = false
			nextSentance()

# Show 'Enter >' or 'Enter.' prompt
func promtNext():
	$nextLabel.visible = true
	if textListIndex == textList.size() - 2:
		$nextLabel.set_text("Enter.")
	else:
		$nextLabel.set_text("Enter >")

func _on_CharacterTimer_timeout():
	charVisible += 1
	$Label.set_visible_characters(charVisible)
	if charVisible == textList[textListIndex].size():
		$CharacterTimer.stop()
		isAnimating = false
		promtNext()
