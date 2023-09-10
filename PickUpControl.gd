extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_loot_area_entered(area):
	print("area : ", area)
	print("Loot area entered from control")
	visible = true
	pass # Replace with function body.


func _on_loot_area_exited(area):
	print("Loot area left from control")
	visible = false
	pass # Replace with function body.
