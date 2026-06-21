extends Dialog

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	sentences = [
		"Hello Test",
		"sentence nr2",
		"does this thing work?",
		"does this thing work? does this thing work? does this thing work?",
		"nvm goodbye!"
		
	]
	await get_tree().create_timer(2).timeout
	start_dialog.emit()
