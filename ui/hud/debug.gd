extends Label

func _process(delta: float) -> void:
	var player: Player = get_tree().get_first_node_in_group("players")
	text = str(player.global_position)
