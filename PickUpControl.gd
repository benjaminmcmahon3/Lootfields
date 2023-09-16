extends Control

@onready var ui_button := $Button

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_loot_area_entered(area):
	visible = true

func _on_loot_area_exited(area):
	visible = false

func _on_loot_item_ready(item_data: ItemData):
	ui_button.text = item_data.display_name
