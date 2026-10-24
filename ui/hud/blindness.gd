extends TextureRect

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var player: Player = get_tree().get_first_node_in_group("players")
	modulate.a = player.blindness
