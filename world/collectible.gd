extends Area2D

enum Item {
	VASE,
	SWORD
}

@export var item: Item
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	if item == Item.VASE:
		sprite.texture = load("res://assets/textures/urn.png")
	else:
		sprite.texture = load("res://assets/textures/wallswords.png")

func _on_body_entered(body: Node2D) -> void:
	var p: Player = body
	if item == Item.VASE:
		p.has_vase = true
	if item == Item.SWORD:
		p.has_sword = true
	queue_free()
