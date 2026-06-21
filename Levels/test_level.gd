extends Node2D

@export var goals: Array[Goal] = []
@export var camera_zoom = 1.0

@onready var player: Player = $Player

func _ready() -> void:
	SignalBus.player_dies.connect(_on_player_died)
	SignalBus.goal_entered.connect(_on_goal_entered)
	if not goals.is_empty():
		goals[0].activate()
	player.player_camera.zoom = Vector2(camera_zoom, camera_zoom)
	

func _on_player_died():
	call_deferred("reload_scene")

func reload_scene():
	get_tree().reload_current_scene()
	
func _on_goal_entered(goal: Goal):
	print(goal.name + " entered")
	goal.queue_free()
	goals.pop_front()
	if not goals.is_empty():
		goals[0].activate()
