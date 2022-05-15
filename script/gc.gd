extends Node

# Tracks the next scene to navigate too
var targetScene = null

var debug_index = 0
var scene_list = [
	"res://levels/mainMenu.tscn",
	"res://levels/intro.tscn",
	"res://levels/one.tscn",
	"res://levels/two.tscn",
	"res://levels/three.tscn",
	"res://levels/garden.tscn",
	"res://levels/four.tscn",
	"res://levels/five.tscn",
	"res://levels/pool.tscn",
	"res://levels/boss.tscn", # Talking
	"res://levels/boss2.tscn", # Active
	"res://levels/boss3.tscn", # Talking + One player frozen at a time
	"res://levels/boss4.tscn", # Cutscene Grandfather sac. Player collects deed
	"res://levels/outro.tscn" # Rip the deed, grass field, Credits
]

var wallMap = null
var currentScene = null

signal fade_to_white_complete

func _ready():
	# Navigate to the main menu on initial load of game
	var isSlow = false
	changeScene("res://levels/mainMenu.tscn", isSlow)
	toggleCanvasLayer(false)

func _process(delta):
	var press = false
	var debug = true
	if debug:
		if Input.is_action_just_pressed("prev_scene"):
			press = true
			debug_index -= 1
			
		elif Input.is_action_just_pressed("next_scene"):
			press = true
			debug_index += 1
	
		if press:
			press = false
			if debug_index > scene_list.size() - 1:
				debug_index = scene_list.size() - 1
			elif debug_index < 0:
				debug_index = 0
			
			var isSlow = false
			changeScene(scene_list[debug_index], isSlow)

func setWallMap(_wallMap):
	wallMap = _wallMap

func isWall(v):
	if wallMap == null:
		return false
	else:
		return wallMap.get_cellv(v) != -1

func playerBlock(value):
	if currentScene != null:
		currentScene.playerBlock(value)

func playerDies():
	if currentScene != null:
		currentScene.playerDies()

func _on_Area2D_body_entered(body):
	setPlayerTask(1, "Exit the room")
	setPlayerTask(2, "Exit the room")

func setPlayerTask(playerNumber, text):
	var label = null
	if playerNumber == 1:
		label = get_node("CanvasLayer/p1_container/container/task_text/MarginContainer/task_text")
	else:
		label = get_node("CanvasLayer/p2_container/container/task_text/MarginContainer/task_text")
	label.set_text(text)

func showArrow_p1(value):
	$AnimationPlayer2.play("p1_arrow_move")
	$CanvasLayer/p1_arrow.visible = value

func showArrow_p2(value):
	$AnimationPlayer2.play("p2_arrow_move")
	$CanvasLayer/p2_arrow.visible = value

func changeScene(newScene, isSlow = true):
	targetScene = newScene
	if isSlow:
		$AnimationPlayer.play("FadeToBlack")
	else:
		swapScenes()

func setCurrentScene(scene):
	currentScene = scene

func customCall(callName):
	if currentScene != null:
		currentScene.customCall(callName)

func nextGhost(ghostSymbol):
	if currentScene == null:
		return false
	return currentScene.nextGhost(ghostSymbol)

func swapScenes():
	if targetScene != null:
		for child in $CurrentLevel.get_children():
			remove_child(child)
			child.queue_free()
		var sceneObject = load(targetScene)
		var sceneTree = sceneObject.instance() 
		$CurrentLevel.add_child(sceneTree)

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "FadeToBlack":
		swapScenes()
		$AnimationPlayer.play("FadeToWhite")
	elif anim_name == "FadeToWhite":
		emit_signal("fade_to_white_complete")

func toggleCanvasLayer(isShown):
	for child in $CanvasLayer.get_children():
		if child.name != "p1_arrow" and child.name != "p2_arrow":
			child.set_visible(isShown)
