extends Label

signal menu_item_selected

func cursor_selected():
	menu_item_selected.emit()
