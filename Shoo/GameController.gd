extends Node

var SCREEN_WIDTH = 1280

var line
var mouse
var player

var canFire = true
var nextLineIndex = 0
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	line = $Line2D
	mouse = $mouse
	player = $player

func _process(delta):
	debug_aim(SCREEN_WIDTH, player, mouse)
	rotatePlayerToFaceMouse(player, mouse)

func getPerpendicular(vec):
	var angle = atan2(vec.y, vec.x) + PI/2
	var x = cos(angle)
	var y = sin(angle)
	return Vector2(x, y).normalized()

func fire():
	if canFire:
		canFire = false
		$shooTimer.start()
		var lines = $lines.get_children()
		var tweens = $lineTweens.get_children()
		var playerVec = player.get_position()
		var mouseVec = mouse.globalVec
		var mouseDir = (mouseVec - playerVec).normalized()
		
		var line  = lines[nextLineIndex]
		var tween = tweens[nextLineIndex]
		
		var span = 70
		rng.randomize()
		var shiftMag = span * rng.randf() - span/2
		var shiftVec = getPerpendicular(mouseDir) * shiftMag
		
		line.set_point_position(0, playerVec)
		line.set_point_position(1, playerVec + mouseDir * SCREEN_WIDTH + shiftVec)
		
		tween.interpolate_property(line, "modulate",
			Color(1, 1, 1, 1), Color(1, 1, 1, 0), 1)
		tween.start()
		
		nextLineIndex = (nextLineIndex + 1) % 6

func debug_aim(SCREEN_WIDTH, player, mouse):
	var mouseVec = mouse.globalVec
	mouse.get_node("debug").set_position(mouseVec)

func rotatePlayerToFaceMouse(player, mouse):
	var playerVec = player.get_position()
	var mouseVec = mouse.globalVec
	var dir = mouseVec - playerVec
	var offset = PI/2
	var angle = atan2(dir.y, dir.x)
	player.set_rotation(angle + offset)


func _on_shooTimer_timeout():
	canFire = true
