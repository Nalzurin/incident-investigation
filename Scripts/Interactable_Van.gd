extends CollisionObject3D
class_name Interactable_Van

@export var prompt_message = "Leave"


func interact():
	GameManager._escape_location()
