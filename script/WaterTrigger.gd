extends Node2D

export (NodePath) var player_path
var player

func _ready():
	player = get_node(player_path)

func _on_Area2D_body_entered(body):
	if body.name == "player":
		player.get_node("SpriteWet").visible = true

func _on_Area2D_body_exited(body):
	if body.name == "player":
		player.get_node("SpriteWet").visible = false
