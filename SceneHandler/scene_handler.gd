extends Node2D

const LEVEL_01 = preload("uid://dugyrmw88lsdj")
const LEVEL_002 = preload("uid://vulcaek0qdup")
const LEVEL_03 = preload("uid://dh0dei3tysdtp")
const LEVEL_SLALOM = preload("uid://b32lcy5a8y0fi")
const LEVEL_04 = preload("uid://hvdf04w2ydc5")
const LEVEL_02 = preload("uid://ce5vxovhmcpf")
const LEVEL_05 = preload("uid://boj8d267mqrdu")
var current_level = null
var levels_in_order: Array = [LEVEL_01,LEVEL_002,LEVEL_03,LEVEL_SLALOM,LEVEL_04,LEVEL_02,LEVEL_05]

func _ready() -> void:
	load_next_level()
	SignalBus.all_goals_reached.connect(load_next_level)

func load_next_level():
	if levels_in_order.size() > 0:
		current_level = levels_in_order.pop_front()
		await get_tree().create_timer(1).timeout
		load_level(current_level)

func load_level(level):
	get_child(0).queue_free()
	var new_level = level.instantiate()
	await get_tree().process_frame
	add_child(new_level)

func reload_level():
	load_level(current_level)
