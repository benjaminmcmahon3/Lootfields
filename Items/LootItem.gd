extends Area2D

class_name LootItem

signal loot_area_entered(loot_scene)
signal loot_area_exited(loot_scene)
signal loot_item_ready(loot_scene)
signal loot_taken(loot)

@onready var sprite := $Sprite2D

@export var item_data: ItemData

var interactable = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.texture = item_data.texture
	emit_signal("loot_item_ready", item_data)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (interactable && Input.is_action_just_pressed("interact")):
		self.queue_free()
		emit_signal("loot_taken")

func _on_body_entered(body):
	if (body.name == "PlayerCharacter"):
		interactable = true
		emit_signal("loot_area_entered", self)

func _on_body_exited(body):
	if (body.name == "PlayerCharacter"):
		interactable = false
		emit_signal("loot_area_exited", self)

func _on_loot_button_pressed():
	print("loot button pressed")
	self.queue_free()
	emit_signal("loot_taken")
