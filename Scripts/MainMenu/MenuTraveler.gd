extends Control

@export var MenuOptions: VBoxContainer
@export var MenuDocuments : VBoxContainer
@export var MenuSettings : VBoxContainer
@export var VolumeLabel : Label
@export var DocumentsControl: Control
@export var DocumentTask : Control
@export var DocumentLog : Control

var docOpen = false
var VolumeEditing = false
signal menu_changed(new_menu : VBoxContainer)
signal doc_toggled()
signal audio_toggled()

func _input(event):
	
	if(VolumeEditing):
		if(Input.is_action_just_pressed("right")):
			SoundManager._increase_sound()
		if(Input.is_action_just_pressed("left")):
			SoundManager._decrease_sound()
		VolumeLabel.text = ""
		for i in SoundManager.current_volume / 0.1:
			VolumeLabel.text += "|"
		
func _play():
	print("Switch scene to game")
	GameManager.switch_state("Game")
	GameManager.load_location()
func _settings():
	menu_changed.emit(MenuSettings)
	MenuSettings.get_parent().visible = true
	MenuOptions.get_parent().visible = false
	MenuDocuments.get_parent().visible = false
	print("Switch scene to settings")
func _settings_return():
	menu_changed.emit(MenuOptions)
	MenuOptions.get_parent().visible = true
	MenuSettings.get_parent().visible = false
	print("Return from settings")
func _settings_audio_toggle():
	audio_toggled.emit()
	VolumeEditing = !VolumeEditing
func _exit():
	print("Exit game")
func _documents():
	menu_changed.emit(MenuDocuments)
	MenuSettings.get_parent().visible = false
	MenuOptions.get_parent().visible = false
	MenuDocuments.get_parent().visible = true
	print("Open documents menu")
func _documents_back():
	menu_changed.emit(MenuOptions)
	MenuOptions.get_parent().visible = true
	MenuDocuments.get_parent().visible = false
	print("Return from documents")
func _document_task():
	docOpen = true
	DocumentsControl.visible = true
	DocumentTask.visible = true
	DocumentLog.visible = false
	doc_toggled.emit()
	print("Open task")
func _document_log():
	docOpen = true
	DocumentsControl.visible = true
	DocumentTask.visible = false
	DocumentLog.visible = true
	doc_toggled.emit()
	print("Open log")
func _document_close():
	docOpen = false
	DocumentsControl.visible = false
	doc_toggled.emit()
	
