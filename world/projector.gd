class_name Projector
extends StaticBody2D

signal activated

var movies: Array[String] = ["woman", "ghoul", "knight"]
var idx: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("projectors")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	activated.emit(movies[idx])
	idx = wrapi(idx + 1, 0, movies.size())
