extends Area2D

enum Item {
	VASE,
	SWORD
}

@export var item: Item

func _on_body_entered(body: Node2D) -> void:
	var p: Player = body
	if item == Item.VASE:
		p.has_vase = true
	if item == Item.SWORD:
		p.has_sword = true
	queue_free()
