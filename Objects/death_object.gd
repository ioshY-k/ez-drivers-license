class_name DeathObject
extends Node2D

func _on_death_object_area_body_entered(_body: Node2D) -> void:
	SignalBus.emit_signal("player_dies")
