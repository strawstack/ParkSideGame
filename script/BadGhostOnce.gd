extends Node2D

var gc
var ghostSymbol

export (int) var moveTime

func _ready():
	gc = get_tree().get_root().get_node("main")
	$Body/GhostArea2D.connect("ghost_hit", self, "on_GhostArea2D_body_entered")
	ghostSymbol = $Body/Ghost/Symbol.get_text()

func _on_GhostArea2D_body_entered(body):
	if body.name == "player":
		gc.playerBlock(true)
		gc.playerDies()
