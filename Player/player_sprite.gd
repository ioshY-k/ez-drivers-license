class_name PlayerSprite extends Node2D

@onready var body: AnimatedSprite2D = $Body
@onready var propeller: Sprite2D = $Body/Propeller


func turn_left_animation():
	body.frame = 2
	propeller.position = Vector2(-75, -208)
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK)
	body.scale.x = 0.4
	tween.tween_property(body, "scale:x", 0.465, 0.2)
	
func turn_right_animation():
	body.frame = 1
	propeller.position = Vector2(65, -189)
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK)
	body.scale.x = 0.4
	tween.tween_property(body, "scale:x", 0.465, 0.2)
	
func go_straight_animation():
	body.frame = 0
	propeller.position = Vector2(-2, -187)
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK)
	body.scale.x = 0.4
	tween.tween_property(body, "scale:x", 0.465, 0.2)
