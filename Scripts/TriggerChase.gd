extends Area3D


@onready var dino = $"../Dino"
@export var ChaseProps : Node3D
var can_chase = false
var started_chase = false

func _toggle_can_chase():
	can_chase = !can_chase
func _on_body_entered(body):
	if body.name == "Player":
		if(can_chase and !started_chase):
			dino.can_chase = true
			dino.visible = true
			dino.toggle_collision()
			SoundManager.play_Chase()
			GameManager.being_chased = true
			for node in ChaseProps.get_children():
				if(node.name == "TreeFallen"):
					node.visible = true
					for nodec in node.get_children():
						if(nodec is CollisionShape3D):
							nodec.set_deferred("disabled", false)
				if(node.name == "ExitWall"):
					node.queue_free()
				if(node.name == "EntranceForest"):
						node.queue_free()
			started_chase = true
			
