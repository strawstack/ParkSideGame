extends Node2D

func _ready():
	pass

func _on_GhostArea2D_body_entered(body):
	if body.name == "player":
		pass
		# Ghost should ask gc if it was hit in correct order
		# If so scene may be complete
		# and ghost might dissapear or flash red and other ghosts might come back
