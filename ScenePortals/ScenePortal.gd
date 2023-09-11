extends Area2D

var scene_path
	
func _on_body_entered(body):
	if (body.name == "PlayerCharacter"):
		print("Portal Entered")
		get_tree().change_scene_to_file(scene_path)

func set_scene_path(path):
	scene_path = path

