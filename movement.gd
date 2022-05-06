extends KinematicBody2D

# Constants
var offset = Vector2(8, 8)
var cellSize = Vector2(16, 16)

# Variables
var isMoving = false 
var currentTile = Vector2()
var targetTile  = Vector2()

var gc
var wallTileMap

func _ready():
	gc = get_tree().get_root().get_node("main")
	wallTileMap = $prims/Tilemap
	currentTile = (position - offset) / cellSize
	targetTile = currentTile

func _process(delta):
	if not isMoving:
		if Input.is_action_pressed("right"):
			var t = Vector2(targetTile.x + 1, targetTile.y)
			if not isCollision(t):
				targetTile.x += 1
				movePlayer(targetTile)
			
		if Input.is_action_pressed("left"):
			targetTile.x -= 1
			movePlayer(targetTile)
			
		if Input.is_action_pressed("down"):
			targetTile.y += 1
			movePlayer(targetTile)
			
		if Input.is_action_pressed("up"):
			targetTile.y -= 1
			movePlayer(targetTile)

func isCollision(targetTile):
	# return wallTileMap.get_cellv(targetTile) != -1
	return false

func movePlayer(targetTile):
	isMoving = true
	
	var tween = get_node("Tween")
	
	var from = currentTile * cellSize + offset 
	var to   = targetTile * cellSize + offset
	
	tween.interpolate_property(self, "position", from, to, 0.2)
	tween.start()

func _on_Tween_tween_completed(object, key):
	isMoving = false
	currentTile = targetTile
