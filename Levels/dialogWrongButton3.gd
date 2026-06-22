extends Dialog

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	sentences = [
		"That's not the gas Pedal!",
		
	]

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("WrongButton3"):
		start_dialog.emit()
		
