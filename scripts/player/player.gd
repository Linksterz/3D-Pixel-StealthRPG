extends CharacterBody3D


const SPEED = 1.7
const RUN_SPEED = 2.8
const AIM_SPEED_MOD = 0.4
const JUMP_VELOCITY = 0.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@export var animation_tree : AnimationTree
@export var movement_blend_path : String
@onready var state_machine = animation_tree.get("parameters/playback")

@export var animation_player : AnimationPlayer
@onready var visuals = $visuals
@export var camera_rig : Node3D
@export var camera : Node3D



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
	var walk_direction = (camera_rig.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#var input_vector = (visuals.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#print(input_vector)
	
	if Input.is_action_pressed("aim"):
		var mouse = get_window().get_mouse_position() - Vector2(get_window().size)/2
		var direction = (camera_rig.transform.basis * Vector3(mouse.x, 0, mouse.y/cos(PI/2+camera.rotation.x))).normalized()
		var rotation_speed := 15.0
		var weight := 1.0 - pow(0.5, delta * rotation_speed)
		visuals.rotation.y = lerp_angle(visuals.rotation.y, atan2(-direction.x, -direction.z), weight)
		
		#animation_tree.set(movement_blend_path,Vector2(input_vector.x,input_vector.z))

	if walk_direction:
		if Input.is_action_pressed("aim"):
			velocity.x = lerp(velocity.x, walk_direction.x * AIM_SPEED_MOD * SPEED, 0.1)
			velocity.z = lerp(velocity.z, walk_direction.z * AIM_SPEED_MOD * SPEED, 0.1)
			
			#animation_tree.set(movement_blend_path,Vector2(input_vector.x,input_vector.z))
			
		else:
			if Input.is_action_pressed("run"):
				velocity.x = lerp(velocity.x, walk_direction.x * RUN_SPEED, 0.1)
				velocity.z = lerp(velocity.z, walk_direction.z * RUN_SPEED, 0.1)

			else:
				velocity.x = lerp(velocity.x, walk_direction.x * SPEED, 0.1)
				velocity.z = lerp(velocity.z, walk_direction.z * SPEED, 0.1)

			var rotation_speed := 10.0
			var weight := 1.0 - pow(0.5, delta * rotation_speed)
			visuals.rotation.y = lerp_angle(visuals.rotation.y, atan2(-walk_direction.x, -walk_direction.z), weight)
		

				
	else:
		velocity.x = lerp(velocity.x, walk_direction.x * SPEED, 0.1)
		velocity.z = lerp(velocity.z, walk_direction.z * SPEED, 0.1)
		
	move_and_slide()

#@onready var state = 0
func _process(delta):
	#if Input.is_action_just_pressed("crouch"):
		#if state != 1:
			#state = 1
			#state_machine.travel("crouch_down")
		#else:
			#state = 0
			#state_machine.travel("idle")
		
	if Input.is_action_pressed("aim"):
		state_machine.travel("aim_walk")
		#state = 0
		
	else:
		if Input.is_action_pressed("movement"):
			if Input.is_action_pressed("run"):
				state_machine.travel("slow_run")
				#state = 0
			#if state == 1:
				#state_machine.travel("crouch_walk")
			else:
				state_machine.travel("walk")
		#if state == 1:
			#state_machine.travel("crouch_idle")
		else:
			state_machine.travel("idle")
