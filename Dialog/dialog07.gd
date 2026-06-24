extends Dialog

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	sentences = [
		"here we are. the final challenge",
		"True mastery of the balance bike. Are you worthy?",
		"show them who you are kid!",
	]
	start_dialog.emit()
