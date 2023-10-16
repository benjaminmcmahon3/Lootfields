extends CanvasLayer

signal pause_game
signal resume_game

@onready var player_menu := $PlayerMenuScreenMargin/PlayerMenu
@onready var loot_scene: PackedScene = preload("res://LootItem.tscn")
@onready var worldspace = get_node("../Worldspace")

func _ready():
	player_menu.visible = false
	connect("pause_game", Callable(worldspace, "on_pause_game"))
	connect("resume_game", Callable(worldspace, "on_resume_game"))

func _input(event):
	if Input.is_action_just_pressed("open_player_menu"):
		toggle_menu()

func toggle_menu():
	player_menu.visible = !player_menu.visible
	if (player_menu.visible == true):
		emit_signal("pause_game")
	elif (player_menu.visible == false):
		emit_signal("resume_game")
