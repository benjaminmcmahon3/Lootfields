extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_loot_area_entered(area):
	print("area : ", area)
	print("Loot area entered from control")
	visible = true

func _on_loot_area_exited(area):
	print("Loot area left from control")
	visible = false

func _on_loot_item_ready(loot_scene):
	$Button.text = loot_scene.display_name
	
