extends RayCast3D

@export var prompt : Label
@export var message : Label
@export var container : Control
@export var description : Label
@export var timeout : Timer
var displaying = false
func _physics_process(delta):
	prompt.text = ""
	message.text = ""
	if(is_colliding() and !displaying):
		var collider = get_collider()
		if collider is Interactable:
			prompt.text = "[E]"
			message.text = collider.prompt_message
			if Input.is_action_just_pressed("interact"):
				display_description(collider)


func display_description(collider : Interactable):
	container.visible = true
	prompt.text = ""
	message.text = ""
	collider.interact(description)
	displaying = true
	timeout.start(8)


func _on_timeout_desc_timeout():
	container.visible = false
	description.text = ""
	displaying = false
