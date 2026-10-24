extends Area2D

func _on_body_entered(body: Node2D) -> void:
	var p: Player = body
	if p.has_sword:
		SignalBus.painting_slashed.emit()
