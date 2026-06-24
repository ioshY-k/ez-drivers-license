extends Dialog

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	sentences = [
		"Okidoke, you know this one",
		"use the merge lane to get up to speed",
		"Then merge into the traffic and follow the road to the first exit you see",
		"no worries, they are at least as scared of you as you are of them!",
	]
	start_dialog.emit()
