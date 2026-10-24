extends Control

@onready var slide: TextureRect = $Slide
@onready var next_slide: Timer = $NextSlide
@onready var music: AudioStreamPlayer = $RagtimePlayer

var movie: Movie
var slide_number: int = 0

func _ready() -> void:
	for p: Projector in get_tree().get_nodes_in_group("projectors"):
		p.activated.connect(show_movie)

func show_movie(mname: String) -> void:
	music.play()
	get_tree().paused = true
	movie = load("res://assets/movies/%s.tres" % [mname])
	slide_number = 0
	show_slide()
	visible = true
	
func show_slide() -> void:
	slide.texture = movie.slides[slide_number]
	next_slide.start(movie.durations[slide_number])
	

func _on_next_slide_timeout() -> void:
	if slide_number < movie.slides.size() - 1:
		slide_number += 1
		show_slide()
	else:
		visible = false
		slide_number = 0
		get_tree().paused = false
		music.stop()
