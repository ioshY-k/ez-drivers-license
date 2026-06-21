class_name Speedometer extends Node2D

@onready var needle: Sprite2D = $Needle

func animate_needle(speed):
	needle.rotation = 1.5 * PI * speed / GameConsts.PLAYER_MAX_VELOCITY - 0.2 * PI
