extends Area2D

signal loot_area_entered(loot_scene)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_area_entered(body):
	if (body.name == "Player"):
		emit_signal("loot_area_entered", self)
