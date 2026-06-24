extends Dialog

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	sentences = [
		"Ahh the good Stuff. A classic...",
		"Remember you'll fall over if you turn with too little speed",
		"That's the red zone in your speedometer",
		"... So don't do that",
		"Good luck!",
		
	]
	start_dialog.emit()
