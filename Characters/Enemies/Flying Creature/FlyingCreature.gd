extends Enemy

@onready var hitbox: Area2D = get_node("Hitbox")

@onready var player01: CharacterBody2D = get_tree().current_scene.get_node("Player")
var distance_play: float = 30.0

func _process(_delta: float) -> void:
	hitbox.knockback_direction = velocity.normalized()
	player01
	#if is_instance_valid(player):
		#player01 = (player.position - global_position).length()
