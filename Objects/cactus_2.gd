extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotation = randf_range(0, 2*PI)
	scale = scale * randf_range(0.4, 0.8)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
