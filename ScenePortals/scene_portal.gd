extends Area2D

signal portal_entered(next_scene)

@export var next_scene_path := "res://Regions/Forest/Forest.tscn"
@export var enabled := true

@onready var ui_label = $Label

var interactable := false

func _ready():
	ui_label.visible = false

func _process(delta):
	if (enabled && interactable && Input.is_action_pressed("interact")):
		emit_signal("portal_entered", self)
		get_tree()
		get_tree().change_scene_to_file(next_scene_path)

func _on_body_entered(body):
	if (body.name == "PlayerCharacter"):
		interactable = true
		print("Portal area entered")
		ui_label.visible = true

func _on_body_exited(body):
	if (body.name == "PlayerCharacter"):
		interactable = false
		print("Portal area exited")
		ui_label.visible = false

