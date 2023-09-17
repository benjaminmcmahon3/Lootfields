extends CanvasLayer

@export var stats: Stats

@onready var ui_health := $Health

func _process(delta):
	ui_health.value = stats.health
