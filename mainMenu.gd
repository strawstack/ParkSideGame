extends Node

var gc

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		$AnimationPlayer.play("FadeToBlack")

func _on_AnimationPlayer_animation_finished(anim_name):
	gc.changeScene("res://levels/one.tscn")

func _on_credits_pressed():
	gc.changeScene("res://levels/credits.tscn")

func _on_start_pressed():
	$AnimationPlayer.play("FadeToBlack")


