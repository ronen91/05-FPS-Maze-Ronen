extends Node

var time = 10

func _ready():
	pause_mode = PAUSE_MODE_PROCESS		# global should never be paused

func _unhandled_input(event):
	if event.is_action_pressed("menu"):	# instead of quitting, show the menu
		#get_tree().quit()
		var menu = get_node_or_null("/root/Game/Menu")
		if menu != null:
			if not menu.visible:
				menu.show()
				get_tree().paused = true 	# pause the game while the menu is visible
			else:
				menu.hide()
				get_tree().paused = false

func update_time(_t):
	time -= 10
	var HUD = get_node_or_null("/root/Maze/UI/HUD")
	if HUD != null:
		HUD.update_time()
	if time <= 0:
		 var _scene = get_tree().change_scene("res://UI/Lose2.tscn")
	
