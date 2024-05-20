extends CharacterBody3D


const SPEED = 1.7
const JUMP_VELOCITY = 0.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


@onready var animation_player = $female/AnimationPlayer
@onready var visuals = $female
@export var camera : Node3D

var walking = false

func _ready():
	#GameManager.set_player(self)
	animation_player.set_blend_time("Idle","walk",0.2)
	animation_player.set_blend_time("walk","Idle",1.0)
	

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (camera.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = lerp(velocity.x, direction.x * SPEED, 0.1)
		velocity.z = lerp(velocity.z, direction.z * SPEED, 0.1)
		
		var rotation_speed := 20.0
		var weight := 1.0 - pow(0.5, delta * rotation_speed)
		visuals.rotation.y = lerp_angle(visuals.rotation.y, atan2(-direction.x, -direction.z), weight)
		
		
		if !walking:
			walking = true
			animation_player.play("walk")
		
	else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)
		velocity.x = lerp(velocity.x, direction.x * SPEED, 0.06)
		velocity.z = lerp(velocity.z, direction.z * SPEED, 0.06)
		#print(velocity)
		
		if walking:
			walking = false
			animation_player.play("Idle")

	move_and_slide()
