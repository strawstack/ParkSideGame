extends Area2D

signal ghost_hit

func _ready():
	pass

func _on_GhostArea2D_body_entered(body):
	if body.name == "player" and get_parent().visible:
		emit_signal("ghost_hit")
