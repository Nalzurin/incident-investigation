extends Area3D
@export var soundpos : Node3D
var VeloSound = preload("res://Scenes/Sounds/3D/Velo_Far.tscn")
var entered = false
@export var trigger_chase : Node3D


func _on_body_entered(body):
	if body.name == "Player":
		if(!entered):
			entered = true
			soundpos.add_child(VeloSound.instantiate())
			trigger_chase._toggle_can_chase()
		
