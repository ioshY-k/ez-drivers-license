extends Node2D

@onready var player_camera: Camera2D = $Camera2D
@onready var player_sprite: Sprite2D = $PlayerSprite

var speed = 0
var acceleration

func _ready() -> void:
	player_camera.make_current()

func _process(delta: float) -> void:
	move_player(delta)
	
	print(speed)
	
	
	
func move_player(delta):
	if Input.is_action_just_pressed("Accelerate"):
		speed += GameConsts.PLAYER_ACCELERATION_VALUE * delta
	elif Input.is_action_just_pressed("Decelerate"):
		speed -= GameConsts.PLAYER_ACCELERATION_VALUE * delta
	if Input.is_action_pressed("TurnLeft"):
		rotation -= GameConsts.PLAYER_ROTATION_VALUE * delta
	elif Input.is_action_pressed("TurnRight"):
		rotation += GameConsts.PLAYER_ROTATION_VALUE * delta
	rotation = fmod(rotation + 2*PI, 2*PI)
	
	position += Vector2(0, -1).rotated(rotation) * speed
	if speed > GameConsts.PLAYER_SPEED_THRESHOLD_FAST:
		speed = max(0, speed - 1 * delta)
		player_sprite.modulate = Color(0.931, 0.397, 0.462, 1.0)
	elif speed > GameConsts.PLAYER_SPEED_THRESHOLD_SLOW:
		speed = max(0, speed - 3 * delta)
		player_sprite.modulate = Color(1, 1, 1)
	elif speed > 0:
		speed = max(0, speed - 5 * delta)
		
	
