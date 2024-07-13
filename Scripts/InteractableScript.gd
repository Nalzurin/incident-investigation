extends CollisionObject3D
class_name Interactable
@export var is_clue = true
@export var prompt_message = "[E]"
@export var prompt_description = "Logo"
var interacted = false
func interact(label : Label):
	label.text = prompt_description
	if is_clue:
		if !interacted:
			interacted = true
			GameManager._found_clue()
