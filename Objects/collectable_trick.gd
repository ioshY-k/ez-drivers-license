extends Node2D

@onready var trick_animation: AnimationPlayer = $TrickAnimation


func _on_area_2d_body_entered(body: Node2D) -> void:
	trick_animation.play("Trick")
	
