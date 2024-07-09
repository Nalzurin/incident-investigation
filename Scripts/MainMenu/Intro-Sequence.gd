extends Node
@export var ClickAnywhere : Control
@export var FootageClassified : TextureRect
@export var Logo : TextureRect
@export var FootageTitle : TextureRect
@export var Cognitohazards : TextureRect
@export var IntroSequence : Control
@export var MainMenu : Control
var doOnce = false
func _input(event):
	if(!doOnce and event is InputEventMouseButton):
		doOnce = true
		ClickAnywhere.visible = false
		_do()
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
