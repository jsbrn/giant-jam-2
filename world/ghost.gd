extends CharacterBody2D

const SPEED: float = 100

@onready var nav: NavigationAgent2D = $NavigationAgent2D
@onready var vision: RayCast2D = $Vision
@onready var target_timer: Timer = $RandomTarget

func _ready() -> void:
	nav.target_position = random_target()

func _process(delta: float) -> void:
	velocity = (nav.get_next_path_position() - global_position).normalized() * SPEED
	
func _physics_process(delta: float) -> void:
	move_and_slide()

func random_target() -> Vector2:
	return Vector2(randi_range(-1500, 1500), randi_range(-1500, 1500))

func can_see_player() -> bool:
	var player: Player = get_tree().get_first_node_in_group("players")
	vision.target_position = player.global_position - global_position
	vision.force_raycast_update()
	var c: CollisionObject2D = vision.get_collider()
	return c != null && c is Player

func _on_nav_recalc_timeout() -> void:
	if can_see_player():
		var player: Player = get_tree().get_first_node_in_group("players")
		nav.target_position = player.global_position
		print("Updating nav target to current player position")

func _on_navigation_agent_2d_target_reached() -> void:
	print("TARGET REACHED!")
	target_timer.start()


func _on_random_target_timeout() -> void:
	nav.target_position = random_target()
