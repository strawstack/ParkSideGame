extends Node

func _ready():
	changeScene(null)

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		$AnimationPlayer.play("FadeToBlack")

func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://main.tscn")

func _on_credits_pressed():
	get_tree().change_scene("res://credits.tscn")

func _on_start_pressed():
	$AnimationPlayer.play("FadeToBlack")

func changeScene(newScene):
	for child in $CurrentLevel.get_children():
		remove_child(child)
		child.queue_free()
	var sceneObject = load("res://main.tscn")
	var sceneTree = sceneObject.instance() 
	$CurrentLevel.add_child(sceneTree)
