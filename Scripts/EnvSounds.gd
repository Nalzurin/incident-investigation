extends Node3D

var Branchsnap = preload("res://Scenes/Sounds/3D/Branch_Snap.tscn")
var Owlhoot = preload("res://Scenes/Sounds/3D/OwlHoot.tscn")
@export var BranchsnapPos : Node3D
@export var BranchsnapTimer : Timer
@export var OwlHootTimer : Timer

func _ready():
	SoundManager.play_Crickets()

func _on_branch_snap_timer_timeout():
	BranchsnapPos.add_child(Branchsnap.instantiate())
	BranchsnapTimer.start(randi_range(50,89))
	


func _on_owl_hoot_timer_timeout():
	var hoot = Owlhoot.instantiate() 
	BranchsnapPos.add_child(hoot)
	hoot.position = Vector3(randi_range(0,100), 10, randi_range(0,100))
	OwlHootTimer.start(randi_range(51,70)) 
