extends Node2D


func _ready() -> void:
	SignalBus.player_dies.connect(_on_player_died)

func _on_player_died():
	call_deferred("reload_scene")

func reload_scene():
	get_tree().reload_current_scene()
