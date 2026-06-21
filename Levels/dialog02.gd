extends Dialog

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	sentences = [
		"Not gonna lie kid, this hurts to watch.",
		"using your short bean fingers ain't gonna bring you far",
		"Now stop joking around and place that mouse wheel on the tabletop.",
		"That's right - park it right there upside down",
		"How else would you generate enough spin?",
		"Now come over here before your bike turns to rust halfway!",
		
	]


func _on_dialog_trigger_body_entered(body: Node2D) -> void:
	start_dialog.emit()
	await get_tree().create_timer(5).timeout
	%TutorialAnimationPlayer.play("Tutorial")

func swap_mouse_frame():
	%MouseTutorialSprite.frame = 1
