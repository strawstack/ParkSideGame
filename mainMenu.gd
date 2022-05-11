extends Node

var gc

func _ready():
	gc = get_tree().get_root().get_node("main")
	$ghostTimer.start()
	$playerTimer.start()
	$ghost.blockInput = true
	$player.blockInput = true

func _on_credits_pressed():
	gc.changeScene("res://levels/credits.tscn")

func _on_start_pressed():
	gc.changeScene("res://levels/intro.tscn")

# 0 up
# 1 right
# 2 down
# 3 left
var ghostPath  = [1, 1, 1, 1, 5, 3, 5, 1, 1, 0, 0, 0, 5, 3, 3, 3, 0, 0, 5, 1, 1, 1, 1, 2, 2, 1, 1, 1, 1, 3, 3, 0, 0, 5, 1, 1, 1, 1, 2, 2, 1, 1, 0, 0, 1, 1, 1, 1, 1, 2, 3, 2, 2, 2, 1, 1, 1, 5, 5, 5, 5, 4]
var ghostIndex = 0

var playerPath = [5, 5, 5, 5, 5, 5, 1, 5, 1, 1, 1, 1, 0, 0, 0, 5, 3, 3, 3, 0, 0, 5, 1, 1, 1, 1, 2, 2, 1, 5, 5, 5, 5, 1, 0, 0, 5, 1, 1, 1, 1, 2, 2, 1, 1, 0, 0, 1, 1, 1, 1, 1, 2, 3, 2, 2, 2, 1, 1, 1, 1, 4]
var playerIndex = 0

func moveGhost():
	var move = ghostPath[ghostIndex]
	if move == 0: # up
		$ghost.targetTile = $ghost.moveUp($ghost.targetTile)
	elif move == 1: # right
		$ghost.targetTile = $ghost.moveRight($ghost.targetTile)
	elif move == 2: # down
		$ghost.targetTile = $ghost.moveDown($ghost.targetTile)
	elif move == 3: # left
		$ghost.targetTile = $ghost.moveLeft($ghost.targetTile)
	elif move == 4:
		pass # end
	else: # null
		$ghostTimer.start()
	ghostIndex = ghostIndex + 1
	if ghostIndex == ghostPath.size():
		ghostIndex = 0
		$ghost.set_position($startLocation.get_position())
		$ghost.init()
		moveGhost()

func movePlayer():
	var move = playerPath[playerIndex]
	if move == 0: # up
		$player.targetTile = $player.moveUp($player.targetTile)
	elif move == 1: # right
		$player.targetTile = $player.moveRight($player.targetTile)
	elif move == 2: # down
		$player.targetTile = $player.moveDown($player.targetTile)
	elif move == 3: # left
		$player.targetTile = $player.moveLeft($player.targetTile)
	elif move == 4:
		pass # end
	else: # null
		$playerTimer.start()
	playerIndex = playerIndex + 1
	if playerIndex == playerPath.size():
		playerIndex = 0
		$player.set_position($startLocation.get_position())
		$player.init()
		movePlayer()

func _on_ghost_move_completed():
	moveGhost()

func _on_player_move_completed():
	movePlayer()

func _on_GhostTimer_timeout():
	moveGhost()

func _on_playerTimer_timeout():
	movePlayer()
