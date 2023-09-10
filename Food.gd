extends Area2D

signal loot_area_entered(loot_scene)

var item_name
var texture_path

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _on_area_entered(body):
	if (body.name == "Player"):
		emit_signal("loot_area_entered", self)
		
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


