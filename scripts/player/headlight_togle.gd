extends Light3D

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("light"):
		visible = !visible
