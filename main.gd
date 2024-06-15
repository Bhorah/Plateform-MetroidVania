extends Node2D

@export var mob_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	var mob = mob_scene.instantiate()
	mob.position.x = 2964
	mob.position.y = 758
	mob.scale.x = 0.5
	mob.scale.y = 0.5
	add_child(mob)
	
	$UI/HealthBar.set_health_bar($Player.health_points)

# Called every frame. 'delta' is the elapsed time since the previous frame.ddd
func _process(delta):
	pass


func _on_death_zone_body_entered(body):
	$Player.queue_free()
	$Player.reload_scene()
