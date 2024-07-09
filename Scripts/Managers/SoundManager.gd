extends Node
#Sound Scenes
var VHSnoise = preload("res://Scenes/Sounds/VHS/VHSLoop.tscn")
var VHSIntro = preload("res://Scenes/Sounds/VHS/VHSIntro.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(VHSnoise.instantiate())
	pass # Replace with function body.
#VHS Intro
func play_VHSIntro():
	add_child(VHSIntro.instantiate())
	pass
# VHS Noise
func play_VHSnoise():
	AudioServer.set_bus_mute(1, false)
	pass
func pause_VHSnoise():
	AudioServer.set_bus_mute(1, true)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
