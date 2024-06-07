extends CharacterBody2D

class_name Mob

@export var move_speed = 200.0

var direction = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$Sprite2D.play("walk")

func _physics_process(_delta):
	
	if (is_on_wall()):
		direction *= -1
	
	velocity.x = move_speed * direction
	$Sprite2D.flip_h = velocity.x < 0

	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		
		var collider = collision.get_collider()
		if collider is Player : 
			print ("Touché")
		
		
		
		
	
		

		
