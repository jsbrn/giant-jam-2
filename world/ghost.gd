extends CharacterBody2D

enum AttackType {
	SLOWNESS,
	BLINDNESS,
	DAMAGE
}

const SPEED: float = 100
@export var attack_type: AttackType
@export var ghost_type: String

@onready var nav: NavigationAgent2D = $NavigationAgent2D
@onready var vision: RayCast2D = $Vision
@onready var target_timer: Timer = $RandomTarget
@onready var anims: AnimatedSprite2D = $AnimatedSprite2D

@onready var collapse: AudioStreamPlayer2D = $Collapse
@onready var slash: AudioStreamPlayer2D = $Slash
@onready var teleport: AudioStreamPlayer2D = $Teleport
@onready var jumpscare: AudioStreamPlayer2D = $Jumpscare


func _ready() -> void:
	anims.play("%s_idle" % [ghost_type])
	nav.target_position = random_target()
	if attack_type == AttackType.SLOWNESS:
		SignalBus.painting_slashed.connect(_on_painting_slashed)

func _process(delta: float) -> void:
	velocity = (nav.get_next_path_position() - global_position).normalized() * SPEED
	
func _physics_process(delta: float) -> void:
	move_and_slide()

func random_target() -> Vector2:
	return Vector2(randi_range(-500, 500), randi_range(-500, 500))

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
		anims.play("%s_attack" % [ghost_type])
		jumpscare.play()
		p.slowness = 2
	if attack_type == AttackType.BLINDNESS:
		if !p.has_vase:
			anims.play("%s_attack" % [ghost_type])
			p.blindness = 2
		else:
			p.has_vase = false
			disappear()
	if attack_type == AttackType.DAMAGE:
		if p.has_sword:
			disappear()
		else:
			anims.play("%s_attack" % [ghost_type])
			p.health -= .5
			slash.play()
			if p.health <= 0:
				p.global_position = random_target()
				p.health = 1
				teleport.play()

func _on_painting_slashed() -> void:
	disappear()

func disappear() -> void:
	await create_tween().tween_property(self, "alpha", 0.0, 3)
	queue_free()


func _on_animated_sprite_2d_animation_finished() -> void:
	anims.play("idle")
