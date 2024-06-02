extends Node3D

@export var player:CharacterBody3D
@export_range(0, 50) var orbit_speed: float = 4.0
var _target_orbit := rotation.y

func _process(delta):
	position = lerp(position,player.position,delta*10.0)
	
	if Input.is_action_just_pressed("cam_orbit_right"):
		_target_orbit += TAU/8
	if Input.is_action_just_pressed("cam_orbit_left"):
		_target_orbit -= TAU/8
	rotation.y = lerpf(rotation.y, _target_orbit, 1.0 - 2.0 ** (-4.0 * delta * orbit_speed))
	if absf(rotation.y - _target_orbit) < 0.02:
		rotation.y = _target_orbit
		#print(rad_to_deg(_target_orbit))
