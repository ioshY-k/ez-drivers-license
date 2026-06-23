extends Dialog

var button_pressed: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	sentences = [
		"That's not the gas Pedal!",
		
	]

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("WrongButton3") and not button_pressed:
		button_pressed = true
		start_dialog.emit()
		await get_tree().create_timer(1.3).timeout
		close_dialog()
		
