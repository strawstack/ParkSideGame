extends KinematicBody2D

# Constants
var offset = Vector2(8, 8)
var cellSize = Vector2(16, 16)

# Variables
var isMoving = false 
var currentTile = Vector2()
var targetTile  = Vector2()
var blockInput = false

var gc
var wallTileMap

var blockList = {
	"up": false,
	"right": false,
	"down": false,
	"left": false,
}

signal move_completed

func _ready():
	gc = get_tree().get_root().get_node("main")
	init()

func init():
	currentTile = (position - offset) / cellSize
	targetTile = currentTile
	$AnimatedSprite.set_speed_scale(0.5)
	$AnimatedSprite.play("idle")

func moveRight(targetTile):
	if not $AnimatedSprite.playing or $AnimatedSprite.get_animation() != "right" or ($AnimatedSprite.get_animation() == "right" and $AnimatedSprite.is_flipped_h() != false):
		$AnimatedSprite.set_speed_scale(1.5)
		$AnimatedSprite.set_flip_h(false)
		$AnimatedSprite.play("right")
	var t = Vector2(targetTile.x + 1, targetTile.y)
	if not isCollision(t):
		targetTile.x += 1
		movePlayer(targetTile)
	return targetTile

func moveDown(targetTile):
	if not $AnimatedSprite.playing or $AnimatedSprite.get_animation() != "down":
		$AnimatedSprite.set_speed_scale(1.5)
		$AnimatedSprite.play("down")
	var t = Vector2(targetTile.x, targetTile.y + 1)
	if not isCollision(t):
		targetTile.y += 1
		movePlayer(targetTile)
	return targetTile

func moveLeft(targetTile):
	if not $AnimatedSprite.playing or $AnimatedSprite.get_animation() != "right" or ($AnimatedSprite.get_animation() == "right" and $AnimatedSprite.is_flipped_h() != true):
		$AnimatedSprite.set_flip_h(true)
		$AnimatedSprite.set_speed_scale(1.5)
		$AnimatedSprite.play("right")
	var t = Vector2(targetTile.x - 1, targetTile.y)
	if not isCollision(t):
		targetTile.x -= 1
		movePlayer(targetTile)
	return targetTile
	
func moveUp(targetTile):
	if not $AnimatedSprite.playing or $AnimatedSprite.get_animation() != "up":
		$AnimatedSprite.set_speed_scale(1.5)
		$AnimatedSprite.play("up")
	var t = Vector2(targetTile.x, targetTile.y - 1)
	if not isCollision(t):
		targetTile.y -= 1
		movePlayer(targetTile)
	return targetTile

func _process(delta):
	if not isMoving:
		var anyAction = false
		if not blockInput:
			if Input.is_action_pressed("right") and not blockList.right:
				anyAction = true
				targetTile = moveRight(targetTile)
				
			if Input.is_action_pressed("left") and not blockList.left:
				anyAction = true
				targetTile = moveLeft(targetTile)

			if Input.is_action_pressed("down") and not blockList.down:
				anyAction = true
				targetTile = moveDown(targetTile)

			if Input.is_action_pressed("up") and not blockList.up:
				anyAction = true
				targetTile = moveUp(targetTile)

		if not anyAction:
			$AnimatedSprite.set_flip_h(false)
			$AnimatedSprite.set_speed_scale(0.5)
			$AnimatedSprite.play("idle")

func isCollision(targetTile):
	return gc.isWall(targetTile)

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
	emit_signal("move_completed")
