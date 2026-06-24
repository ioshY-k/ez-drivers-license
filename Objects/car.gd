extends "res://Objects/death_object.gd"

#var starting_position
@export var speed = 1700
@export var is_reverse = false

func _ready() -> void:
	position.x += randf_range(-60, 60)

func _process(delta: float) -> void:
	if not is_reverse:
		if position.y < 0:
			position.y = 122644
		position.y -= speed * delta
	else:
		if position.y > 122644:
			position.y = 0
		position.y += speed * delta
