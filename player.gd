extends CharacterBody2D

class_name Player

signal health_diff

@export var jump_height : float
@export var jump_time_to_peak : float
@export var jump_time_to_descent: float

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak) * -1
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1

@onready var spawnPositionX = 678
@onready var spawnPositionY = 622

static var health_points = 5
@onready var move_speed = 400
@export var blink_number = 5

var previous_move: Vector2
var direction:int

var can_jump = true
var coyote_timer = 0
const MAX_COYOTE = 0.05

func _physics_process(delta):
	
	check_can_jump(delta)

	if Input.is_action_just_pressed("jump") :
		if can_jump:
			velocity.y = jump_velocity
		if is_on_wall_only():
			velocity.y = jump_velocity * 0.8
			velocity.x = direction * 1000

	direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * move_speed
		$Sprite.play("Walk")
		previous_move = velocity
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
		$Sprite.stop()

	move_and_slide()
	
	
func check_can_jump(delta):
	if is_on_floor():
		coyote_timer = 0
		can_jump = true
	else :
		coyote_timer += delta
		if(coyote_timer > MAX_COYOTE):
			can_jump = false
			velocity.y += get_gravity() * delta
	
func get_gravity():
	return jump_gravity if velocity.y < 0.0 else fall_gravity
	
func reload_scene():
	get_tree().reload_current_scene()
	
func take_damage():
	health_points -= 1
	
	emit_signal("health_diff", -1)
	
	if(health_points == 0):
		die()
	
func die():
	reload_scene()
	
func blink():
	for i in blink_number:
		$Sprite.set_visible(!$Sprite.is_visible())
		OS.delay_msec(5)
	



