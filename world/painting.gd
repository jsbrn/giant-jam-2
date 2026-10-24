extends Area2D

var slashed: bool
@onready var sprite: Sprite2D = $Sprite2D
@onready var slash: AudioStreamPlayer2D = $Slash
@onready var tear: AudioStreamPlayer2D = $Tear

func _on_body_entered(body: Node2D) -> void:
	var p: Player = body
	if p.has_sword && !slashed:
		SignalBus.painting_slashed.emit()
		slashed = true
		slash.play()
		tear.play()
		sprite.texture = load("res://assets/textures/painting_torn.png")
