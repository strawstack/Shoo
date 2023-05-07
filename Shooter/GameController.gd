extends Node

var SCREEN_WIDTH = 1280

var player
var line

func _ready():
	player = $player
	line = $Line2D

func _process(delta):
	$mouse.aim(SCREEN_WIDTH, player, line)
