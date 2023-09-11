extends Camera2D

var zoom_speed = 0.1
var min_zoom = 1.0
var max_zoom = 5.0

func _input(event):
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("zoom_in"):
			zoom_in()
		if Input.is_action_just_pressed("zoom_out"):
			zoom_out()

func zoom_in():
	zoom.x = min(max_zoom, zoom.x + zoom_speed)
	zoom.y = min(max_zoom, zoom.y + zoom_speed)

func zoom_out():
	zoom.x = max(min_zoom, zoom.x - zoom_speed)
	zoom.y = max(min_zoom, zoom.y - zoom_speed)
