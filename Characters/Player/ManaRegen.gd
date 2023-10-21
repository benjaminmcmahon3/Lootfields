extends Timer

@onready var regen_delay := $RegenDelay

func start_regen():
	stop()
	regen_delay.stop()
	regen_delay.start()

func stop_regen():
	stop()
	regen_delay.stop()

func _on_regen_delay_timeout():
	start()
