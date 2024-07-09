extends CollisionObject3D
class_name Interactable

@export var prompt_message = "[E]"
@export var prompt_description = "Logo"

func interact(label : Label):
	label.text = prompt_description
