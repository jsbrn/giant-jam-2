extends CharacterBody2D

func _process(delta: float) -> void:
	var player: Player = get_tree().get_first_node_in_group("players")
	

func _physics_process(delta: float) -> void:
	move_and_slide()
