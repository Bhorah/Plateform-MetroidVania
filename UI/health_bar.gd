extends HBoxContainer

@export var heart_scene: PackedScene

var heart_full = preload("res://assets/kenney_platformer-art-deluxe/Base pack/HUD/hud_heartFull.png")
var heart_empty = preload("res://assets/kenney_platformer-art-deluxe/Base pack/HUD/hud_heartEmpty.png")

var health

# Called when the node enters the scene tree for the first time.
func _ready():
	null
	
	
func set_health_bar(heart_count):
	health = heart_count
	for i in health:
		var heart = heart_scene.instantiate()
		heart.texture = heart_full
		add_child(heart)

func update_health(health_diff):
	health += health_diff
	for i in get_child_count() :
		if (health > i):
			get_child(i).texture = heart_full
		else: 
			get_child(i).texture = heart_empty

