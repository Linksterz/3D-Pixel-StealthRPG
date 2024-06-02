extends Node3D

@export var cam_rig : Node3D
@onready var ray = $ray

func _process(delta):
	ray.rotation.y = cam_rig.rotation.y

func _on_east_area_entered(area):
	get_tree().call_group("east_wall","toggle")

func _on_north_area_entered(area):
	get_tree().call_group("north_wall","toggle")

func _on_west_area_entered(area):
	get_tree().call_group("west_wall","toggle")

func _on_south_area_entered(area):
	get_tree().call_group("south_wall","toggle")


func _on_east_area_exited(area):
	get_tree().call_group("east_wall","toggle")

func _on_north_area_exited(area):
	get_tree().call_group("north_wall","toggle")

func _on_west_area_exited(area):
	get_tree().call_group("west_wall","toggle")

func _on_south_area_exited(area):
	get_tree().call_group("south_wall","toggle")
