extends Dialog

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	sentences = [
		"way to go kid! Now, hit the road!",
		"Don't forget to do loooong swoops with your mouse.",
		"use the whole Tabletop!",
		"Now go ride that baby bike into the sunset",
	]
	start_dialog.emit()
