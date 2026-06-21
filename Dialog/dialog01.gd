extends Dialog

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	sentences = [
		"Aight Kid, todays the day!",
		"Last series of tests.",
		"You remember how to steer this beauty I hope?",
		"Your old trusty Balance Bike was sometimes a stubborn brat after all!",
		"Lets warm up with an appetizer.",
		"Paddle your way back there over the crosswalk.",
		
	]
	start_dialog.emit()
