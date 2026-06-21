extends Dialog

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	sentences = [
		"Ahh the good Stuff",
		"A classic",
		"Think you got it in you?",
		"Remember you'll fall over if you turn with too little speed",
		"don't do that",
		"Good luck!",
		
	]
	start_dialog.emit()
