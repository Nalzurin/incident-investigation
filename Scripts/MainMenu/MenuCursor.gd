extends Label

@export var  menu_parent : VBoxContainer
@export var cursor_offset : Vector2

var cursor_index = 0
var docToggled = false
func get_menu_item_at_index(index : int ) -> Control:
	if menu_parent == null:
		return null
	if index >= menu_parent.get_child_count() or index < 0:
		return null
	return menu_parent.get_child(index) as Control
	
func set_cursor_from_index(index : int ):
	var menu_item = get_menu_item_at_index(index)
	if menu_item == null:
		return 
	var position = menu_item.global_position
	var ssize = menu_item.size
	global_position = Vector2(position.x, position.y + ssize.y/2.0) - (size / 2.0)
	cursor_index = index

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input = 0
	if(!docToggled):
		if(Input.is_action_just_pressed("left")):
			input -= 1
		if(Input.is_action_just_pressed("backward")):
			input += 1
		if(Input.is_action_just_pressed("forward")):
			input -= 1
		if(Input.is_action_just_pressed("right")):
			input += 1
	set_cursor_from_index(cursor_index + input)
	if(Input.is_action_just_pressed("ui_select")):
		if(!docToggled):
			var current_menu_item = get_menu_item_at_index(cursor_index)
			if current_menu_item != null and current_menu_item.has_method("cursor_selected"):
				current_menu_item.cursor_selected()

func _on_main_menu_menu_changed(new_menu):
	menu_parent = new_menu
	set_cursor_from_index(0)
	pass # Replace with function body.


func _on_main_menu_doc_toggled():
	docToggled = !docToggled
	print(docToggled)
