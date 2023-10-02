extends CanvasLayer

@onready var background := $ColorRect
@onready var text := $VBoxContainer/Label

func show_you_died():
	self.visible = true
