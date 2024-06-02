extends Node3D


# Toggle flash light
func _input(event):
	if event.is_action_pressed("light"):
		get_tree().call_group("flash_light","toggle")
		
	if event.is_action_pressed("zoom_in"):
		$Display.zoom += 0.1
	if event.is_action_pressed("zoom_out"):
		$Display.zoom -= 0.1

# Close game
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().quit()
