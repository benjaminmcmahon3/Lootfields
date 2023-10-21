extends Panel
class_name InventoryListItem

signal use

var hover_stylebox: StyleBoxFlat = self.get_theme_stylebox("panel_hover")
var item_unique_id

func _ready():
	size_flags_horizontal = SIZE_EXPAND_FILL
	size_flags_vertical = SIZE_SHRINK_CENTER
	
	var player = get_node("/root/Main/Worldspace").get_children()[0].get_node("PlayerCharacter")
	self.connect("use", Callable(player, "item_used"))

func _on_mouse_entered():
	self.add_theme_stylebox_override("panel", hover_stylebox)

func _on_mouse_exited():
	self.remove_theme_stylebox_override("panel")

func _on_gui_input(event):
	if event is InputEventMouseButton:
		# Mouse button released
		if event.pressed == false:
			print("emitting : ", item_unique_id)
			emit_signal("use", item_unique_id)
