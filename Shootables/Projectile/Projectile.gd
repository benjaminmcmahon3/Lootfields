extends RigidBody2D
class_name Projectile

@export var projectileStats: ProjectileStats

func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	body._on_projectile_shape_entered(projectileStats)
	self.queue_free()
