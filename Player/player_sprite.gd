class_name PlayerSprite extends Node2D

@onready var body: AnimatedSprite2D = $Body
@onready var propeller: Sprite2D = $Body/Propeller
var is_falling: bool = false
var is_standing: bool = false

func _ready() -> void:
	%LegsAnimationPlayer.speed_scale = 2

func _process(delta: float) -> void:
	print(is_falling)

func propeller_spin_animation(speed):
	if %PropellerAnimationPlayer.current_animation != "Spin":
		%PropellerAnimationPlayer.play("Spin")
	%PropellerAnimationPlayer.speed_scale = abs(speed) / GameConsts.PLAYER_ACCELERATION_VALUE * 3

func propeller_stop_animation():
	%PropellerAnimationPlayer.speed_scale = 1
	%PropellerAnimationPlayer.play("Idle")

func feet_accelerate_anim():
	if not %LegsAnimationPlayer.current_animation == "Accelerate":
		is_standing = false
		%LegsAnimationPlayer.play("Accelerate")
	
func feet_stand_anim():
	if not is_standing:
		is_standing = true
		%LegsAnimationPlayer.play("Stand")
		body.frame = 0
		propeller.show()
		%LegLeft.show()
		%LegRight.show()
		%FootLeft.show()
		%FootRight.show()

func turn_left_animation():
	if is_falling:
		return
	body.frame = 2
	propeller.position = Vector2(-75, -208)
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK)
	body.scale.x = 0.3
	tween.tween_property(body, "scale:x", 0.465, 0.2)
	
func turn_right_animation():
	if is_falling:
		return
	body.frame = 1
	propeller.position = Vector2(65, -189)
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK)
	body.scale.x = 0.3
	tween.tween_property(body, "scale:x", 0.465, 0.2)
	
func go_straight_animation():
	if is_falling:
		return
	body.frame = 0
	propeller.position = Vector2(-2, -187)
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK)
	body.scale.x = 0.3
	tween.tween_property(body, "scale:x", 0.465, 0.2)
	
func fall_right_animation():
	if not is_falling:
		is_falling = true
		is_standing = false
		propeller.hide()
		%LegLeft.hide()
		%LegRight.hide()
		%FootLeft.hide()
		%FootRight.hide()
		body.frame = 3
		var tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK)
		body.scale.x = 0.3
		tween.tween_property(body, "scale:x", 0.465, 0.2)

func reset_dash_timer():
	%FeetDashTimer.start()

func change_right_foot(below: bool):
	%FootRight.frame = below
func change_left_foot(below: bool):
	%FootLeft.frame = below

func _on_feet_dash_timer_timeout() -> void:
	%LegsAnimationPlayer.play("Fly")
