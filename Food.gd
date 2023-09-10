extends Area2D

signal loot_area_entered(loot_scene)
signal loot_area_exited(loot_scene)
signal loot_taken(loot)

var item_name
var texture_path

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_area_entered(area):
	if (area.name == "Player"):
		emit_signal("loot_area_entered", self)
	pass
	
func _on_area_exited(area):
	if (area.name == "Player"):
		emit_signal("loot_area_exited", self)
	pass

func _to_string():
	return "{Loot: %s}" % [item_name]

func set_item_name(name: String):
	item_name = name;
	
func set_texture(texture_path: String):
	texture_path = texture_path
	$Sprite2D.texture = load(texture_path)
	
func offload_state():
	return {
		"name": item_name,
		"texture_path": texture_path
	}

func _on_loot_button_pressed():
	emit_signal("loot_taken", self)
	pass # Replace with function body.
