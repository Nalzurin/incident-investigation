extends CharacterBody3D

@onready var FootstepSound = preload("res://Scenes/Sounds/3D/FootstepPlayer2.tscn")
@export var FootstepNodeLeft : Node3D
@export var FootstepNodeRight : Node3D
@export var StepTimer : Timer
var speed
const WALK_SPEED = 3.0
const SPRINT_SPEED = 6.0
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.003

var step_cooldown = 1
var can_step = true
var step_left = true
const BOB_FREQ = 2
const BOB_AMP = 0.04
var t_bob = 0
const BASE_FOV = 75.0
const FOV_CHANGE = 1.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 9.8
@onready var head = $Head
@onready var camera = $Head/Camera3D 
@onready var color_rect = $CanvasLayer/ColorRect

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if(!GameManager.is_web):
		color_rect.visible = true
		

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(60))
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if(Input.is_action_pressed("sprint")):
		speed = SPRINT_SPEED
		step_cooldown = 0.4
	else:
		speed = WALK_SPEED
		step_cooldown = 0.8
	
	if(is_on_floor()):
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta*2.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta*2.0)
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)

	var velocity_clamped = clamp(velocity.length(), 0.5, SPRINT_SPEED*2)
	if(camera.transform.origin.x > 0.03 or camera.transform.origin.x < -0.03):
		if(velocity_clamped > 1 and can_step):
			print("playing step")
			if(step_left):
				FootstepNodeLeft.add_child(FootstepSound.instantiate())
			else:
				FootstepNodeRight.add_child(FootstepSound.instantiate())
			step_left = !step_left
			can_step = false
			StepTimer.start(step_cooldown)
	var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 8.0)
	move_and_slide()
func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ/2) * BOB_AMP
	return pos


func _on_step_cooldown_timeout():
	can_step = true


func _on_hitbox_body_entered(body):
	if(body.name == "Dino" and GameManager.being_chased):
		GameManager._caught_by_dino()
