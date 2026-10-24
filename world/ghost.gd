extends CharacterBody2D

enum AttackType {
	SLOWNESS,
	BLINDNESS,
	TELEPORT
}

const SPEED: float = 100
@export var attack_type: AttackType

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
	return c != null && c is Player && c.global_position.distance_to(global_position) <= 1080

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


func _on_player_touch_body_entered(body: Node2D) -> void:
	var p: Player = body
	if attack_type == AttackType.SLOWNESS:
		p.slowness = 2
	if attack_type == AttackType.BLINDNESS:
		p.blindness = 2
	if attack_type == AttackType.TELEPORT:
		p.global_position = random_target()
