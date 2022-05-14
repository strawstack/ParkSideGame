extends Area2D

signal ghost_hit

func _ready():
	pass

func _on_GhostArea2D_body_entered(body):
	var isVisible = get_parent().visible
	if get_parent().name == "Body":
		isVisible = get_parent().get_parent().visible
	if body.name == "player" and isVisible:
		emit_signal("ghost_hit")
