class_name Goal extends Node2D

var collision_count = 0

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	visible = false

func activate():
	visible = true
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_area_2d_area_entered(area: Area2D) -> void:
	collision_count += 1
	print("wheel entered")
	if collision_count == 2:
		SignalBus.goal_entered.emit(self)


func _on_area_2d_area_exited(area: Area2D) -> void:
	print("wheel exited")
	collision_count -= 1
