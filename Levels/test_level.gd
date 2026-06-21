extends Node2D

@export var goals: Array[Goal] = []

func _ready() -> void:
	SignalBus.player_dies.connect(_on_player_died)
	SignalBus.goal_entered.connect(_on_goal_entered)
	if not goals.is_empty():
		goals[0].activate()
	

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
