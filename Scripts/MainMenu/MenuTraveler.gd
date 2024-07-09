extends Control

@export var MenuOptions: VBoxContainer
@export var MenuDocuments : VBoxContainer
@export var DocumentsControl: Control
@export var DocumentTask : Control
@export var DocumentLog : Control
var docOpen = false
signal menu_changed(new_menu : VBoxContainer)
signal doc_toggled()
func _input(event):
	if(docOpen and event is InputEventMouseButton):
		print("Closing doc")
		docOpen = false
		DocumentsControl.visible = false
		doc_toggled.emit()

func _play():
	print("Switch scene to game")
	get_tree().change_scene_to_file("res://TestScene.tscn")
func _settings():
	print("Switch scene to settings")
func _exit():
	print("Exit game")
func _documents():
	menu_changed.emit(MenuDocuments)
	MenuOptions.visible = false
	MenuDocuments.visible = true
	print("Open documents menu")
func _documents_back():
	menu_changed.emit(MenuOptions)
	MenuOptions.visible = true
	MenuDocuments.visible = false
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
