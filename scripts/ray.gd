extends Area3D


func _process(delta):
	rotation.y = $"..".cam_rig.rotation.y
