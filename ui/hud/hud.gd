extends Control

@onready var sword: TextureRect = $Sword
@onready var vase: TextureRect = $Vase

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var player: Player = get_tree().get_first_node_in_group("players")
	vase.visible = player.has_vase
	sword.visible = player.has_sword
