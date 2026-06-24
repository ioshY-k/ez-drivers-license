extends Node2D

var player_cam: Camera2D

func _ready() -> void:
	player_cam = get_tree().get_first_node_in_group("Camera")

func _process(delta: float) -> void:
	for child in get_children():
		child.global_rotation = player_cam.global_rotation
