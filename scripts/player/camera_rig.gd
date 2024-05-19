extends Node3D

@onready var background_viewport = $base_camera/background_viewport_container/background_viewport
@onready var forground_viewport = $base_camera/forground_viewport_container/forground_viewport

@onready var background_cam = $base_camera/background_viewport_container/background_viewport/background_cam
@onready var forground_cam = $base_camera/forground_viewport_container/forground_viewport/forground_cam

# Called when the node enters the scene tree for the first time.
func _ready():
	resize()

func resize():
	background_viewport.size = DisplayServer.window_get_size()
	forground_viewport.size = DisplayServer.window_get_size()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	background_cam.global_transform = GameManager.player.camera_point.global_transform
	forground_cam.global_transform = GameManager.player.camera_point.global_transform
