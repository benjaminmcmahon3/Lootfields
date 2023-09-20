extends RigidBody2D

@export var projectile: Projectile

func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print("fireball body shape entered : ", body)
	
	if body is Enemy:
		body.on_projectile_impact(projectile)
		self.queue_free()
	
