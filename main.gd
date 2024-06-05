extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#$Map.hide()
	#$Player.hide()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_death_zone_body_entered(body):
	$Player.queue_free()
	$Player.reload_after_death()
