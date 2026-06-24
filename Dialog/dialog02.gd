extends Dialog

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	sentences = [
		"I sure hope you know how to do turns... cause... They are coming up now.",
		"Just lean right into them and you will follow them eazy peezy",
		"You heard me: Lean your mouse left and right to make turns...",
	]

func _on_dialog_trigger_body_entered(body: Node2D) -> void:
	start_dialog.emit()
	await get_tree().create_timer(5).timeout
	%TutorialAnimationPlayer.play("Turn")

func swap_mouse_frame():
	%MouseTutorialSprite.frame = 1
