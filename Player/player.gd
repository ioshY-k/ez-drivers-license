class_name Player extends CharacterBody2D

@onready var player_camera: Camera2D = $Camera2D
@onready var player_sprite: PlayerSprite = $PlayerSprite
@onready var crashed_timer: Timer = $CrashedTimer
@onready var speedometer: Speedometer = $CanvasLayer/Speedometer
@onready var speed_particles: CPUParticles2D = $SpeedParticles
@onready var hyper_speed_particles: CPUParticles2D = $HyperSpeedParticles
@onready var camera: Camera2D = $Camera2D
@onready var tire_track_particles: CPUParticles2D = $TireTrackParticles
@onready var arrow: Sprite2D = $Arrow


var speed = 0
var rotation_modifier = 0
var is_player_crashed = false
var is_first_acceleration = true
var is_player_turning = false
var camera_rotation = 0
var current_goal_pos: Vector2
var distance_to_goal = 0


func _ready() -> void:
	player_camera.make_current()
	camera_rotation = rotation
	camera.global_rotation = rotation
	camera.rotation_smoothing_enabled = false

	SignalBus.freeze_player.connect(func():
		set_process_mode(Node.PROCESS_MODE_DISABLED)
	)
	SignalBus.unfreeze_player.connect(func():
		set_process_mode(Node.PROCESS_MODE_INHERIT)
	)
	SignalBus.all_goals_reached.connect(func():
		arrow.hide()
	)
	
	await get_tree().process_frame
	camera.rotation_smoothing_enabled = true

func _process(delta: float) -> void:
	if not is_player_crashed:
		move_player(delta)
		turn_player(delta)
	animate_player()
	animate_speedometer()
	
	arrow.global_rotation = PI/2 + self.global_position.angle_to_point(current_goal_pos)
	distance_to_goal = self.global_position.distance_to(current_goal_pos)
	if distance_to_goal < 1800:
		arrow.modulate.a = 0.5 * (distance_to_goal - 900) / 900
	else:
		arrow.modulate.a = 0.5
	camera.global_rotation = camera_rotation
	

func turn_player(delta):
	if speed >= 0 and is_first_acceleration:
		return
		
	if Input.is_action_pressed("TurnLeft"):
		if speed > 0 and speed < GameConsts.PLAYER_SPEED_THRESHOLD_SLOW:
			crash_player()
			return
		rotation_modifier -= GameConsts.PLAYER_ROTATION_VALUE * delta
		tire_track_particles.emitting = true
	elif Input.is_action_pressed("TurnRight"):
		if speed > 0 and speed < GameConsts.PLAYER_SPEED_THRESHOLD_SLOW:
			crash_player()
			return
		rotation_modifier += GameConsts.PLAYER_ROTATION_VALUE * delta
		tire_track_particles.emitting = true
	else:
		tire_track_particles.emitting = false
	if rotation_modifier == 0:
		if is_player_turning:
			camera_rotation = rotation
			is_player_turning = false
		return
	
	is_player_turning = true
	
	if rotation_modifier > 0:
		rotation_modifier = max(rotation_modifier - 0.1 * delta, 0)
	elif rotation_modifier < 0:
		rotation_modifier = min(rotation_modifier + 0.1 * delta, 0)
		
	rotation_modifier = min(rotation_modifier, 0.03)
	rotation_modifier = max(rotation_modifier, -0.03)
		
	if speed > 0:
		rotation = fmod(rotation + rotation_modifier, 2*PI)
	else: 
		rotation = fmod(rotation - rotation_modifier, 2*PI)
	
	
func move_player(delta):	
	if Input.is_action_just_pressed("Accelerate"):
		speed += GameConsts.PLAYER_ACCELERATION_VALUE * delta
	elif Input.is_action_just_pressed("Decelerate"):
		speed -= GameConsts.PLAYER_ACCELERATION_VALUE * delta
	
	if speed > GameConsts.PLAYER_SPEED_THRESHOLD_FAST:
		speed = max(speed - GameConsts.PLAYER_FRICTION_VALUE * 2  * delta, 0)
		speed_particles.emitting = true
		#print("speedy ")
	elif speed > GameConsts.PLAYER_SPEED_THRESHOLD_SLOW:
		is_first_acceleration = false
		speed = max(speed - GameConsts.PLAYER_FRICTION_VALUE * 2  * delta, 0)
		speed_particles.emitting = false
		#print("normal ")
	elif speed >= 0:
		speed = max(speed - GameConsts.PLAYER_FRICTION_VALUE * 3  * delta, 0)
		speed_particles.emitting = false
		#print("slowy ")
	else: #reverse
		speed = min(speed + GameConsts.PLAYER_FRICTION_VALUE * 3  * delta, 0)
		speed_particles.emitting = false
		#print("reverse ")
		
	#Max Speed	
	speed = min(speed, GameConsts.PLAYER_MAX_VELOCITY)
	speed = max(speed, -GameConsts.PLAYER_MAX_VELOCITY / 2)
	if speed == 0:
		is_first_acceleration = true
	
	if speed <= GameConsts.PLAYER_MAX_VELOCITY - 10:
		velocity = Vector2(0, -1).rotated(rotation) * speed
		hyper_speed_particles.emitting = false
	else:
		velocity = Vector2(0, -1).rotated(rotation) * speed * 1.6
		hyper_speed_particles.emitting = true
	
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
		
		player_sprite.feet_stand_anim()
	else:
		player_sprite.propeller_spin_animation(speed)
	
	if Input.is_action_just_pressed("Accelerate"):
		player_sprite.feet_accelerate_anim()
		player_sprite.reset_dash_timer()
	

func animate_speedometer():
	speedometer.animate_needle(speed)
	
func crash_player():
	is_player_crashed = true
	speed = 0
	rotation_modifier = 0
	player_sprite.fall_right_animation()
	crashed_timer.start()


func _on_crashed_timer_timeout() -> void:
	is_player_crashed = false
	player_sprite.is_falling = false
	player_sprite.feet_stand_anim()
