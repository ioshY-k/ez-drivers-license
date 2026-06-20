class_name PlayerSprite extends Node2D

@onready var body: AnimatedSprite2D = $Body
@onready var propeller: Sprite2D = $Body/Propeller
@onready var propeller_animation_player: AnimationPlayer = $PropellerAnimationPlayer

func propeller_spin_animation(speed):
	if propeller_animation_player.current_animation != "Spin":
		propeller_animation_player.play("Spin")
	propeller_animation_player.speed_scale = abs(speed) / GameConsts.PLAYER_ACCELERATION_VALUE * 3

func propeller_stop_animation():
	propeller_animation_player.speed_scale = 1
	propeller_animation_player.play("Idle")

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

func change_right_foot(below: bool):
	%FootRight.frame = below
func change_left_foot(below: bool):
	%FootLeft.frame = below
