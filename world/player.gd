class_name Player
extends CharacterBody2D

const SPEED: float = 300.0
var blindness: float = 0
var slowness: float = 0

func _ready() -> void:
	add_to_group("players")

func _process(delta: float) -> void:
	blindness -= 0.1 * delta
	slowness -= 0.1 * delta

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		velocity = direction * SPEED * (0.5 if slowness > 0 else 1)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)

	move_and_slide()
