extends CanvasLayer

@export var stats: Stats = null:
	set = set_stats

@onready var ui_health := $Health
@onready var ui_mana := $Mana

func set_stats(new_stats: Stats):
	stats = new_stats
	stats.connect("changed", Callable(self, "update_stats_hud"))

func update_stats_hud():
	ui_health.value = stats.health
	ui_mana.value = stats.mana
	
