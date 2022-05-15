extends Control

# List of sentences and current index
var textList
var textListIndex

# Number of characters visible
var charVisible

var isAnimating

signal text_complete

var isActive = false

var gc

func _ready():
	gc = get_tree().get_root().get_node("main")
	$nextLabel.visible = false
	visible = false
	isAnimating = false

func showText(_textList):
	if isAnimating == false:
		textList = _textList
		textListIndex = 0
		var element = textList[textListIndex]
		if typeof(element) == TYPE_ARRAY:
			$Label.set_text(element[0])
			gc.customCall(element[1])
		else:
			$Label.set_text(element)
		charVisible = 0
		$Label.set_visible_characters(charVisible)
		visible = true
		isAnimating = true
		$CharacterTimer.start()

func nextSentance():
	textListIndex += 1
	if textListIndex >= textList.size():
		visible = false
		emit_signal("text_complete")
	else:
		var element = textList[textListIndex]
		if typeof(element) == TYPE_ARRAY:
			$Label.set_text(element[0])
			gc.customCall(element[1])
		else:
			$Label.set_text(element)
		charVisible = 0
		$Label.set_visible_characters(charVisible)
		isAnimating = true
		$CharacterTimer.start()

func _process(delta):
	if not isActive:
		return
	if Input.is_action_just_pressed("ui_accept"):
		if isAnimating:
			$CharacterTimer.stop()
			isAnimating = false
			var element = textList[textListIndex]
			if typeof(element) == TYPE_ARRAY:
				element = element[0]
			charVisible = element.length()
			$Label.set_visible_characters(charVisible)
			promtNext()
		else:
			# display all characters
			$nextLabel.visible = false
			nextSentance()

# Show 'Enter >' or 'Enter.' prompt
func promtNext():
	$nextLabel.visible = true
	if textListIndex == textList.size() - 1:
		$nextLabel.set_text("Enter.")
	else:
		$nextLabel.set_text("Enter >")

func _on_CharacterTimer_timeout():
	charVisible += 1
	$Label.set_visible_characters(charVisible)
	var element = textList[textListIndex]
	if typeof(element) == TYPE_ARRAY:
		element = element[0]
	if charVisible == element.length():
		$CharacterTimer.stop()
		isAnimating = false
		promtNext()
