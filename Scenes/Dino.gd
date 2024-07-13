extends CharacterBody3D

@onready var navigation_agent : NavigationAgent3D = $NavigationAgent3D
@export var target_to_chase : Node3D
const movement_speed = 5.0
@export var can_chase = false
var gravity = 9.8
@onready var collision_shape = $CollisionShape3D

func toggle_collision():
	collision_shape.set_deferred("disabled", !collision_shape.disabled)
func _ready():
	set_physics_process(false)
	# Make sure to not await during _ready.
	call_deferred("actor_setup")
func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame
	# Now that the navigation map is no longer empty, set the movement target.
	navigation_agent.target_position = target_to_chase.global_position
	set_physics_process(true)	

func _physics_process(delta):
	if can_chase:
		navigation_agent.target_position = target_to_chase.global_position
		var next_location = navigation_agent.get_next_path_position()
		var new_velocity = global_position.direction_to(next_location) * movement_speed
		velocity = new_velocity
		move_and_slide()

