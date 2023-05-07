extends Node2D

func aim(SCREEN_WIDTH, player, line):
	var playerVec = player.get_position()
	var mouseVec = get_global_mouse_position()
	
	var mouseDir = (mouseVec - playerVec).normalized()
	
	line.set_point_position(0, playerVec)
	line.set_point_position(1, playerVec + mouseDir * SCREEN_WIDTH)

	$debug.set_position(mouseVec)
