extends Node2D

var gc
var ghostSymbol

var moveLocation
var hasMoved = false

export (int) var moveTime

func _ready():
	gc = get_tree().get_root().get_node("main")
	$Body/GhostArea2D.connect("ghost_hit", self, "on_GhostArea2D_body_entered")
	ghostSymbol = $Body/Ghost/Symbol.get_text()
	moveLocation = get_node_or_null("MoveLocation").get_position()
	if moveLocation != null:
		moveGhost()

func moveGhost():
	var tween = get_node("Tween")
	if hasMoved:
		tween.interpolate_property($Body, "position",
			moveLocation, Vector2.ZERO, moveTime)
	else:
		tween.interpolate_property($Body, "position",
			Vector2.ZERO, moveLocation, moveTime)
	hasMoved = not hasMoved
	tween.start()

func on_GhostArea2D_body_entered():
	if gc.nextGhost(ghostSymbol):
		$Body/GhostArea2D.set_monitoring(false)
		visible = false

func _on_Tween_tween_all_completed():
	moveGhost()
