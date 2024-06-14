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

func _on_area_2d_area_entered(area):
	for body in $Area2D.get_overlapping_areas():
		if body.is_in_group("player"):
			(body.get_parent() as Player).take_damage()


