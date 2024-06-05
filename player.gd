extends CharacterBody2D


@export var move_speed = 400

@export var jump_height : float
@export var jump_time_to_peak : float
@export var jump_time_to_descent: float

@onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak) * -1
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1

@onready var spawnPositionX = 678
@onready var spawnPositionY = 622

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * move_speed
		$Sprite2D.play("Walk")
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
		$Sprite2D.stop()

	move_and_slide()
	
func get_gravity():
	return jump_gravity if velocity.y < 0.0 else fall_gravity
	
func reload_after_death():
	get_tree().reload_current_scene()
	
