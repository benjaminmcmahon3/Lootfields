extends CharacterBody2D
class_name Enemy

@export var stats: Stats = null

@export var movement_target: Node2D
@export var navigation_bounds: Node2D
@export var navigation_agent: NavigationAgent2D
@export var enable_movement := false

@onready var ui_health := $Health
@onready var timer := $Timer
@onready var projectile := preload("res://Shootables/MageGreenOrb.tscn")

enum {
	IDLE,
	WANDER
}

var player: PlayerCharacter
var state = null
var isPlayerInRange: bool

func _ready():
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0
	
	if enable_movement:
		call_deferred("actor_setup")

func actor_setup():
	await get_tree().physics_frame
	state = IDLE

func set_movement_target(target: Vector2):
	navigation_agent.target_position = target

func _physics_process(delta):
	match state:
		IDLE:
			find_new_target()
			state = WANDER
		WANDER:
			continue_navigation(delta)
			
			if navigation_agent.is_navigation_finished():
				state = IDLE

func find_new_target():
	var bounds: Rect2 = navigation_bounds.get_viewport_rect()
	while true:
		var x = randf_range(bounds.position.x, bounds.end.x)
		var y = randf_range(bounds.position.y, bounds.end.y)
		var new_potential_target = Vector2(x, y)
		
		navigation_agent.target_position = new_potential_target
		print("navigation target pos: ", navigation_agent.target_position)
		if navigation_agent.is_target_reachable() == false:
			continue
		else:
			break

func continue_navigation(delta):
	var current_agent_position = global_position
	var next_path_position = navigation_agent.get_next_path_position()
	
	var new_velocity: Vector2 = next_path_position - current_agent_position
	velocity = new_velocity.normalized() * stats.speed
	
	move_and_slide()

func _on_projectile_shape_entered(projectile: ProjectileStats):
	print("Enemy hit with projectile for %s damage" % [projectile.damage])
	take_damage(projectile.damage);

func take_damage(damage: int):
	stats.take_damage(damage)
	ui_health.value = stats.health
	if (stats.health == 0):
		death()

func death():
	$AnimatedSprite2D.stop()
	var tween = create_tween()
	tween.tween_property(self, "rotation", deg_to_rad(90.0), 0.25)
	tween.tween_callback(func(): self.queue_free())

func _on_range_body_entered(body: PhysicsBody2D):
	timer.start()
	player = body

func shoot_projectile():
	var _projectile = projectile.instantiate()
	get_node("/root/Main/Worldspace").add_child(_projectile)
	_projectile.projectileStats.speed = 100
	_projectile.add_collision_exception_with(self)
	_projectile.global_position = self.position + Vector2(0, -5.0)

	var offset = (player.global_position - self.position).normalized()
	_projectile.apply_central_impulse(offset)
	_projectile.look_at(player.global_position)
	var angle_to_player = get_angle_to(player.global_position)
	var direction = Vector2(cos(angle_to_player), sin(angle_to_player))
	_projectile.linear_velocity = direction * _projectile.projectileStats.speed

func _on_range_area_body_exited(body):
	timer.stop()
	player = null

func _on_timer_timeout():
	shoot_projectile()
