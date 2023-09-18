extends CanvasLayer

@onready var ui_inventory = $Inventory

# Called when the node enters the scene tree for the first time.
func _ready():
	ui_inventory.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func toggle_inventory():
	ui_inventory.visible = !ui_inventory.visible
