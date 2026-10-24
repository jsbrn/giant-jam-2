extends Label

func _process(delta: float) -> void:
	var p: Player = get_tree().get_first_node_in_group("players")
	text = ""
	text += "\nsword: %s" % [p.has_sword]
	text += "\nvase: %s" % [p.has_vase]
	text += "\nhp: %.2f" % [p.health]
