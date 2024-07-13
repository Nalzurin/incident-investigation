extends Node

var is_web = true
var current_state = "Menu"
var clues_found = 0
var clues_total = 7
var being_chased = false

func switch_state(state : String):
	current_state = state

func _found_clue():
	clues_found+=1
func _escape_location():
	switch_state("ESCAPE")
	load_survey()
func _caught_by_dino():
	switch_state("DEAD")
	load_survey()
func load_location():
	match randi_range(1,4):
		1: 
			get_tree().change_scene_to_file("res://TestScene.tscn")
		2: 
			get_tree().change_scene_to_file("res://Scenes/Maze2.tscn")
		3:
			get_tree().change_scene_to_file("res://Scenes/Maze3.tscn")
		4:
			get_tree().change_scene_to_file("res://Scenes/Maze4.tscn")
	
func load_survey():
	get_tree().call_deferred("change_scene_to_file","res://survey.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("exit") and !is_web):
		get_tree().free()
