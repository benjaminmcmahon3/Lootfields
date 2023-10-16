extends Panel
class_name InventoryListItem

#var old_color
var on_hover_stylebox = self.get_theme_stylebox("normal").duplicate()

func _ready():
	size_flags_horizontal = SIZE_EXPAND_FILL
	size_flags_vertical = SIZE_SHRINK_CENTER


func _on_mouse_entered():
#	old_color = self.modulate
#	self.modulate = Color8(52, 76, 100, 255)
	on_hover_stylebox.bg_color = Color.from_string("#000000a0", Color.BLACK)
	self.add_theme_stylebox_override("normal", on_hover_stylebox)


func _on_mouse_exited():
	self.remove_theme_stylebox_override("on_hover_stylebox")

