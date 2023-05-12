extends Node2D

var globalVec

func _ready():
	globalVec = get_global_mouse_position()
	
func _process(_delta):
	globalVec = get_global_mouse_position()
