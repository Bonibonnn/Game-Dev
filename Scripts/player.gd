extends CharacterBody2D

@export var speed := 100.0

@onready var animated_sprite: AnimatedSprite2D = get_node_or_null("AnimatedSprite2D")


func _physics_process(_delta: float) -> void:
	# Godot provides these actions by default (arrow keys).
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	move_and_slide()

	update_animation(direction)


func update_animation(direction: Vector2) -> void:
	if animated_sprite == null:
		return

	# There are no front/back animations. Vertical movement keeps the last
	# left/right direction, while horizontal movement selects the facing side.
	if direction.x < 0.0:
		animated_sprite.flip_h = true
	elif direction.x > 0.0:
		animated_sprite.flip_h = false

	if direction == Vector2.ZERO:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("walk")
