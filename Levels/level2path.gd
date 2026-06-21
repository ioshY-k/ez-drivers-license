extends Path2D
@onready var path_follow_2d: PathFollow2D = $PathFollow2D

func path_start():
	await get_tree().create_timer(2).timeout
	var tween = get_tree().create_tween()
	tween.tween_property(path_follow_2d, "progress_ratio", 1, 50)
