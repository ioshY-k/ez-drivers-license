extends Dialog

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	dialog_ended.connect(start_path)
	sentences = [
		"Doing great so far. next up: The timed section",
		"Be faster than the marking and the drivers license is almost yours",
		"You. Are. Speed.",
	]
	start_dialog.emit()

func start_path():
	%TimeChallengePath.path_start()
