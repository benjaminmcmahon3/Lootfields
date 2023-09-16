extends Area2D

class_name LootItem

signal loot_area_entered(loot_scene)
signal loot_area_exited(loot_scene)
signal loot_item_ready(loot_scene)
signal loot_taken(loot)

var item_name
var display_name
var texture_path

var interactable = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("loot_item_ready", self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (interactable && Input.is_action_pressed("interact")):
		print("interact")
		emit_signal("loot_taken", self)

func _on_body_entered(body):
	if (body.name == "PlayerCharacter"):
		interactable = true
		emit_signal("loot_area_entered", self)

func _on_body_exited(body):
	if (body.name == "PlayerCharacter"):
		interactable = false
		emit_signal("loot_area_exited", self)

func set_item_name(name: String):
	item_name = name
	
func set_item_display_name(name: String):
	display_name = name
	
func set_texture(texture_path: String):
	texture_path = texture_path
	$Sprite2D.texture = load(texture_path)
	
func offload_state():
	return {
		"name": item_name,
		"display_name": display_name,
		"texture_path": texture_path
	}

func _on_loot_button_pressed():
	emit_signal("loot_taken", self)
