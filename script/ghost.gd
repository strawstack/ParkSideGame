extends Node2D

var gc
var ghostSymbol

func _ready():
	gc = get_tree().get_root().get_node("main")
	$GhostArea2D.connect("ghost_hit", self, "on_GhostArea2D_body_entered")
	ghostSymbol = $Ghost/Symbol.get_text()

func on_GhostArea2D_body_entered():
	if gc.nextGhost(ghostSymbol):
		$GhostArea2D.set_monitoring(false)
		visible = false
