class_name Dialog extends Node

var sentences: Array[String] = []
var current_sentence = 0
var dialog_started: bool = false
@onready var dialog_text: Label = $DialogText
@onready var dialog_box: Sprite2D = $DialogBox

signal start_dialog
signal dialog_ended

func _ready():
	dialog_text.modulate.a = 0
	dialog_box.scale = Vector2.ZERO
	start_dialog.connect(next_sentence)

func _process(delta: float) -> void:
	if dialog_started and Input.is_action_just_pressed("Dialog Next"):
		next_sentence()

func next_sentence():
	if not dialog_started:
		dialog_started = true
		SignalBus.freeze_player.emit()
		var tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK). set_ease(Tween.EASE_IN)
		tween.tween_property(dialog_box,"scale", Vector2(1.181,0.617), 0.4)
		tween.tween_property(dialog_text,"modulate:a", 1, 0.2)
		dialog_text.text = sentences[current_sentence]
		current_sentence += 1
	elif current_sentence >= sentences.size():
		close_dialog()
	else:
		dialog_text.text = sentences[current_sentence]
		wobble_box()
		current_sentence += 1

func close_dialog():
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK). set_ease(Tween.EASE_IN).set_parallel(true)
	tween.tween_property(dialog_box,"scale", Vector2.ZERO, 0.4)
	tween.tween_property(dialog_text,"modulate:a", 0, 0.2)
	SignalBus.unfreeze_player.emit()
	dialog_ended.emit()
	await tween.finished
	queue_free()
	

func wobble_box():
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK)
	dialog_box.scale = Vector2.ZERO
	tween.tween_property(dialog_box,"scale", Vector2(1.181,0.617), 0.2)
	tween.tween_property(dialog_text,"modulate:a", 1, 0.2)
