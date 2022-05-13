extends Node2D

var gc

var isOpen = false

func _ready():
	gc = get_tree().get_root().get_node("main")
	$Timer.start()

func _on_Area2D_body_entered(body):
	if body.name == "player":
		if shouldKill():
			gc.playerBlock(true)
			gc.playerDies()

func shouldKill():
	var first = $AnimatedSprite.get_animation() == "open" and $AnimatedSprite.get_frame() >= 4
	var second = $AnimatedSprite.get_animation() == "close" and $AnimatedSprite.get_frame() <= 1
	return first or second

func toggleTile():
	if isOpen:
		$AnimatedSprite.play("close")
	else:
		$AnimatedSprite.play("open")
	isOpen = not isOpen

func _on_Timer_timeout():
	toggleTile()

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.get_animation() == "open":
		for body in $Area2D.get_overlapping_bodies():
			if body.name == "player":
				gc.playerBlock(true)
				gc.playerDies()
