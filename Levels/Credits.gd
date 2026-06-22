extends ColorRect

func _ready() -> void:
	await get_tree().create_timer(3).timeout
	$Label.text = "the next day..."
	await get_tree().create_timer(2).timeout
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0, 1)
	await tween.finished
	queue_free()
