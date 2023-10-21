extends Panel
class_name InventoryListItem

var hover_stylebox: StyleBoxFlat = self.get_theme_stylebox("panel_hover")

func _ready():
	size_flags_horizontal = SIZE_EXPAND_FILL
	size_flags_vertical = SIZE_SHRINK_CENTER

func _on_mouse_entered():
	self.add_theme_stylebox_override("panel", hover_stylebox)

func _on_mouse_exited():
	self.remove_theme_stylebox_override("panel")

