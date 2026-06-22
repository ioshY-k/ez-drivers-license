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
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Restart"):
		reload_scene()
	if Input.is_action_just_pressed("Skip"):
		SignalBus.all_goals_reached.emit()
	if Input.is_action_just_pressed("Honk"):
		$Honk.pitch_scale = randf_range(1.5,1.7)
		$Honk.play()
	

func _on_player_died():
	call_deferred("reload_scene")

func reload_scene():
	get_tree().current_scene.reload_level()
	
func _on_goal_entered(goal: Goal):
	print(goal.name + " entered")
	goals.pop_front()
	if not goals.is_empty():
		goals[0].activate()
	else:
		SignalBus.all_goals_reached.emit()
	var tween = get_tree().create_tween()
	tween.tween_property(goal.blink_effect, "modulate:a", 1, 0.2)
	tween.tween_property(goal, "modulate:a", 0, 0.2)
	await tween.finished
	goal.queue_free()
