extends Node
@export var ClickAnywhere : Control
@export var FootageClassified : TextureRect
@export var Logo : TextureRect
@export var FootageTitle : TextureRect
@export var Cognitohazards : TextureRect
@export var IntroSequence : Control
@export var MainMenu : Control
@export var Cursor : Label
var doOnce = false
#debug skip
var skip_intro = false
@onready var color_rect = $CanvasLayer/ColorRect

func _ready():
	if(!GameManager.is_web):
		color_rect.visible = true
		
func _input(event):
	if(!doOnce and event is InputEventMouseButton):
		doOnce = true
		ClickAnywhere.visible = false
		if(skip_intro):
			MainMenu.visible = true
			Cursor.is_menu = true
		else:
			await _do()
	pass # Replace with function body.
func _do():
	SoundManager.play_VHSnoise()
	FootageClassified.visible = true
	await(get_tree().create_timer(5).timeout)
	FootageClassified.visible = false
	Logo.visible = true
	var tween = get_tree().create_tween()
	SoundManager.play_VHSIntro()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(Logo, "modulate", Color(1,1,1,1), 8)
	await(get_tree().create_timer(14).timeout)
	FootageTitle.visible = true
	await(get_tree().create_timer(6).timeout)
	Cognitohazards.visible = true
	await(get_tree().create_timer(4).timeout)
	IntroSequence.visible = false
	MainMenu.visible = true
	Cursor.is_menu = true
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
