extends Node
#Sound Scenes
var VHSnoise = preload("res://Scenes/Sounds/VHS/VHSLoop.tscn")
var VHSIntro = preload("res://Scenes/Sounds/VHS/VHSIntro.tscn")
var Crickets = preload("res://Scenes/Sounds/VHS/Crickets.tscn")
var Chase = preload("res://Scenes/Sounds/VHS/ChaseLoop.tscn")
var current_volume = 1
@onready var master_bus = AudioServer.get_bus_index("Master")
# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(VHSnoise.instantiate())
	
	pass # Replace with function body.
func _increase_sound():
	current_volume = clampf(current_volume+0.1,0.0,1.0)
	AudioServer.set_bus_volume_db(master_bus, linear_to_db(current_volume))
func _decrease_sound():
	current_volume = clampf(current_volume-0.1,0.0,1.0)
	AudioServer.set_bus_volume_db(master_bus, linear_to_db(current_volume))
func toggle_mute():
	AudioServer.set_bus_mute(1, !AudioServer.is_bus_mute(1))
	AudioServer.set_bus_mute(0, !AudioServer.is_bus_mute(0))
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
# Crickets
func play_Crickets():
	add_child(Crickets.instantiate())
func play_Chase():
	add_child(Chase.instantiate())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
