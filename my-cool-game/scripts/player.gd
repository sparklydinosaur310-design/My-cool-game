extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -270.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var last_bounce_msec := -1000

func bounce(strength: float) -> void:
	velocity.y = strength
	last_bounce_msec = Time.get_ticks_msec()

func just_bounced() -> bool:
	return Time.get_ticks_msec() - last_bounce_msec < 150

var invincible := false
var safe_history: Array[Vector2] = []
var sample_timer := 0.0
const SAMPLE_EVERY = 0.25
const HISTORY_SIZE = 2

func _ready() -> void:
	if SaveData.checkpoints and Run.respawn_valid:
		global_position = Run.respawn_pos
		Run.respawn_valid = false
		protect(2.0)
	safe_history = [global_position]

func get_respawn_point() -> Vector2:
	return safe_history[0]

func protect(seconds: float) -> void:
	invincible = true
	var tween = create_tween().set_loops(int(seconds / 0.2))
	tween.tween_property(animated_sprite, "modulate:a", 0.3, 0.1)
	tween.tween_property(animated_sprite, "modulate:a", 1.0, 0.1)
	await get_tree().create_timer(seconds).timeout
	invincible = false
	animated_sprite.modulate.a = 1.0

func hurt() -> void:
	velocity.y = -180
	protect(1.2)

func _physics_process(delta: float) -> void:
	# Adds the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the imput direction: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animation
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	
	
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	if is_on_floor():
		sample_timer += delta
		if sample_timer >= SAMPLE_EVERY:
			sample_timer = 0.0
			safe_history.append(global_position)
			if safe_history.size() > HISTORY_SIZE:
				safe_history.pop_front()
