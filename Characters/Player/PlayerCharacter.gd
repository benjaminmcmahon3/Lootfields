extends CharacterBody2D
class_name PlayerCharacter

signal player_tree_entered(player_scene)
signal player_damaged(amount)
signal player_death

@export var stats: Stats
@export var inventory: Inventory
@export var shoot_logic: ShootLogic

@onready var ui_sprite := $AnimatedSprite2D
@onready var health_regen := $HealthRegen
@onready var mana_regen := $ManaRegen

const fireball_scene: Resource = preload("res://Shootables/Fireball.tscn")

func _ready():
	stats.global_position = global_position
	call_deferred("prin")

func prin():
	print(stats.health)

func _physics_process(delta):
	stats.global_position = global_position

	var _velocity = Vector2.ZERO # The player's movement vector.

	if Input.is_action_pressed("move_up"):
		_velocity.y -= 1

	if Input.is_action_pressed("move_right"):
		_velocity.x += 1

	if Input.is_action_pressed("move_left"):
		_velocity.x -= 1

	if Input.is_action_pressed("move_down"):
		_velocity.y += 1

	if _velocity.length() > 0:
		_velocity = _velocity.normalized() * stats.speed

	self.velocity = _velocity
	position += velocity * delta

	if Input.is_action_just_pressed("shoot"):
		shoot()

	move_and_slide()

func _process(delta):
	if not velocity.length():
		ui_sprite.play("idle")
	elif velocity.x > 0:
		ui_sprite.play("walk_right")
	elif velocity.x < 0:
		ui_sprite.play("walk_left")
	elif velocity.y >= 0:
		ui_sprite.play("walk_down")
	elif velocity.y < 0:
		ui_sprite.play("walk_up")

func _enter_tree():
	emit_signal("player_tree_entered", self)

func take_damage(damage: int):
	stats.take_damage(damage)
	
	health_regen.start_regen()
	
	if stats.health == 0:
		health_regen.stop_regen()
		mana_regen.stop_regen()
		death()

func death():
	ui_sprite.stop()
	var tween = create_tween()
	tween.tween_property(self, "rotation", deg_to_rad(90.0), 0.25)
	tween.tween_callback(Callable(death_tween_callback))

func death_tween_callback():
	emit_signal("player_death")
	process_mode = Node.PROCESS_MODE_DISABLED

func shoot():
	# temp mana cost
	var mana_cost = 8
	
	if stats.mana < mana_cost:
		return
	
	var offset = Vector2(0, -5.0)
	
	shoot_logic.spawn(
		self,
		fireball_scene,
		get_parent(),
		self.position + offset,
		(get_global_mouse_position() - self.position).normalized()
	)
	
	stats.use_mana(4)
	mana_regen.start_regen()

func _on_projectile_shape_entered(projectile: ProjectileStats):
	take_damage(projectile.damage)

func _on_health_regen_timeout():
	stats.set_health(clamp(stats.health + stats.health_regen_step, 0, stats.max_health))
	
	if stats.health == stats.max_health:
		health_regen.stop_regen()
#	stats.add_health(stats.health_regen_step)

func _on_mana_regen_timeout():
	stats.set_mana(clamp(stats.mana + stats.mana_regen_step, 0, stats.max_mana))
	
	if stats.mana == stats.max_mana:
		mana_regen.stop_regen()
#	stats.add_mana(stats.mana_regen_step)
