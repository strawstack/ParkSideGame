tool

extends Node2D

# References
export (bool) var run = false setget runPrims
export (NodePath) var tileMapPath
export (Vector2) var size
export (int) var extraDoors

# Constants
var tileMap
var rng

func placeWalls():
	tileMap = get_node(tileMapPath)
	for y in range(size.y):
		for x in range(size.x):
			tileMap.set_cellv(Vector2(x, y), 0)

func clearWalls():
	tileMap = get_node(tileMapPath)
	for y in range(size.y):
		for x in range(size.x):
			tileMap.set_cellv(Vector2(x, y), -1)

func createRooms():
	tileMap = get_node(tileMapPath)
	var rooms = {}
	for y in range(1, size.y - 1, 2):
		for x in range(1, size.x - 1, 2):
			tileMap.set_cellv(Vector2(x, y), -1)
			rooms[Vector2(x, y)] = 1
	return rooms

func runPrims(value):
	# x and y of size need to be of form 3 + 2 * k
	size.x = floor((size.x - 3) / 2) * 2 + 3
	size.y = floor((size.y - 3) / 2) * 2 + 3
	
	prims()

func prims():
	tileMap = get_node(tileMapPath)
	
	rng = RandomNumberGenerator.new()
	rng.set_seed(OS.get_time().second)
	rng.randomize()

	placeWalls()
	
	var rooms = createRooms()

	# Startcell is random
	var startCell = Vector2(1 + 2 * rng.randi_range(0, floor((size.x - 1) / 2) - 1), 1 + 2 * rng.randi_range(0, floor((size.y - 1) / 2) - 1))
	
	if not (startCell in rooms):
		# Place start cell on even row
		if floor(fmod(startCell.y, 2)) != 1:
			startCell.y += 1
		
		# Adjust x coord to be over a room
		if startCell.x == size.x - 1:
			startCell.x -= 1
		elif not (startCell in rooms):
			startCell.x += 1

	var adj = [
		Vector2(0, -1),
		Vector2(1, 0),
		Vector2(0, 1),
		Vector2(-1, 0)
	]
	
	var doors = []
	
	for a in adj:
		var door = startCell + a
		if inBounds(size, door):
			doors.append(door)

	var connectedRooms = {}
	connectedRooms[startCell] = true

	while len(doors) > 0:
		var nextDoor = getRandomDoor(doors)
		var twoRooms = getRoomsFromDoor(nextDoor)
		var unconnectedRooms = getUnconnectedRooms(connectedRooms, twoRooms)
		
		if len(unconnectedRooms) > 0:
			tileMap.set_cellv(nextDoor, -1)

		# Add new doors
		for r in unconnectedRooms:
			connectedRooms[r] = true
			for a in adj:
				var door = r + a
				if inBounds(size, door):
					doors.append(door)
	
	doors = []
	var extraDoorsLocal = extraDoors
	if extraDoorsLocal != 0:
		for y in range(1, size.y - 1):
			for x in range(1, size.x - 1, 2):
				var offset = 0
				if floor(fmod(y, 2)) != 0:
					offset = 1
				var door = Vector2(x + offset, y)
				if inBounds(size, door) and tileMap.get_cellv(door) != -1:
					doors.append(door)
	
	while len(doors) > 0 and extraDoorsLocal > 0:
		var nextDoor = getRandomDoor(doors)
		tileMap.set_cellv(nextDoor, -1)
		extraDoorsLocal -= 1
	
func getRandomDoor(doors):
	var doorIndex = rng.randi_range(0, len(doors) - 1)
	var temp = doors[doorIndex]
	doors[doorIndex] = doors[len(doors) - 1]
	doors.pop_back()
	return temp

func getRoomsFromDoor(door):
	if floor(fmod(door.x, 2)) == 0:
		return [door + Vector2(-1, 0), door + Vector2(1, 0)]
	else:
		return [door + Vector2(0, -1), door + Vector2(0, 1)]

func getUnconnectedRooms(connectedRooms, roomList):
	var unconnected_rooms = []
	for r in roomList:
		if not (r in connectedRooms):
			unconnected_rooms.append(r)
	return unconnected_rooms

func inBounds(size, cell):
	return cell.x > 0 and cell.x < size.x - 1 and cell.y > 0 and cell.y < size.y - 1
