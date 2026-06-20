class_name Player extends CharacterBody2D

@onready var player_camera: Camera2D = $Camera2D
@onready var player_sprite: PlayerSprite = $PlayerSprite
@onready var crashed_timer: Timer = $CrashedTimer

var speed = 0
var rotation_modifier = 0
var player_crashed = false

func _ready() -> void:
	player_camera.make_current()

func _process(delta: float) -> void:
	if not player_crashed:
		move_player(delta)
	animate_player()
	
	print(velocity, speed)
	
	
	
func move_player(delta):
	# Turn Player
	if Input.is_action_pressed("TurnLeft"):
		if speed < GameConsts.PLAYER_SPEED_THRESHOLD_SLOW:
			crash_player()
			return
		rotation_modifier -= GameConsts.PLAYER_ROTATION_VALUE * delta
	elif Input.is_action_pressed("TurnRight"):
		if speed < GameConsts.PLAYER_SPEED_THRESHOLD_SLOW:
			crash_player()
			return
		rotation_modifier += GameConsts.PLAYER_ROTATION_VALUE * delta
	
	if rotation_modifier > 0:
		rotation_modifier = max(rotation_modifier - 0.1 * delta, 0)
	elif rotation_modifier < 0:
		rotation_modifier = min(rotation_modifier + 0.1 * delta, 0)
		
	rotation_modifier = min(rotation_modifier, 0.03)
	rotation_modifier = max(rotation_modifier, -0.03)
		
	rotation = fmod(rotation + rotation_modifier, 2*PI)
	
	
	# Move Player	
	if Input.is_action_just_pressed("Accelerate"):
		speed += GameConsts.PLAYER_ACCELERATION_VALUE * delta
	elif Input.is_action_just_pressed("Decelerate"):
		speed -= GameConsts.PLAYER_ACCELERATION_VALUE * delta
	
	if speed > GameConsts.PLAYER_SPEED_THRESHOLD_FAST:
		speed = max(speed - GameConsts.PLAYER_FRICTION_VALUE  * delta, 0)
		player_sprite.modulate = Color(0.931, 0.397, 0.462, 1.0)
		print("speedy ")
	elif speed > GameConsts.PLAYER_SPEED_THRESHOLD_SLOW:
		speed = max(speed - GameConsts.PLAYER_FRICTION_VALUE * 2  * delta, 0)
		player_sprite.modulate = Color(1, 1, 1)
		print("normal ")
	elif speed >= 0:
		speed = max(speed - GameConsts.PLAYER_FRICTION_VALUE * 3  * delta, 0)
		player_sprite.modulate = Color(0.015, 0.645, 0.806, 1.0)
		print("slowy ")
	else:
		speed = min(speed + GameConsts.PLAYER_FRICTION_VALUE * 5  * delta, 0)
		print("reverse ")
		
	#Max Speed	
	speed = min(speed, GameConsts.PLAYER_MAX_VELOCITY)
	
	velocity = Vector2(0, -1).rotated(rotation) * speed
	
	move_and_slide()
	
		
func animate_player():
	if Input.is_action_just_released("TurnLeft") or Input.is_action_just_released("TurnRight"):
		player_sprite.go_straight_animation()
	if Input.is_action_just_pressed("TurnLeft"):
		player_sprite.turn_left_animation()
	if Input.is_action_just_pressed("TurnRight"):
		player_sprite.turn_right_animation()
	if speed == 0:
		player_sprite.propeller_stop_animation()
	else:
		player_sprite.propeller_spin_animation(speed)

func crash_player():
	player_crashed = true
	speed = 0
	rotation_modifier = 0
	player_sprite.modulate = Color(0.12, 0.12, 0.12, 1.0)
	crashed_timer.start()


func _on_crashed_timer_timeout() -> void:
	player_sprite.modulate = Color(1, 1, 1)
	player_crashed = false
