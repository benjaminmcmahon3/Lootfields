# This class contains the logic for shooting projectiles and related logic
extends Resource
class_name ShootLogic

func spawn(
		originator: Node2D,
		projectile_scene: Resource,
		container_scene: Node2D,
		spawn_position: Vector2,
		impulse: Vector2,
		look_at: Vector2 = originator.get_global_mouse_position(),
		linear_velocity_direction: Vector2 = get_default_linear_velocity_direction(originator)
	):
	var projectile = projectile_scene.instantiate()
	
	assert(projectile.projectileStats != null, "Projectiles must have a `projectileStats` class: %s" % [projectile])
	
	projectile.global_position = spawn_position
	
	container_scene.add_child(projectile)
	
	projectile.apply_central_impulse(impulse)
	projectile.look_at(originator.get_global_mouse_position())
	projectile.add_collision_exception_with(originator)
	
	projectile.linear_velocity = linear_velocity_direction * projectile.projectileStats.speed

func get_default_linear_velocity_direction(originator):
	var angle_to_mouse = originator.get_angle_to(originator.get_global_mouse_position())
	var direction = Vector2(cos(angle_to_mouse), sin(angle_to_mouse))
	return direction
