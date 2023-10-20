extends CanvasLayer

@onready var background := $ColorRect
@onready var text := $VBoxContainer/Label

func make_visible():
	self.visible = true
