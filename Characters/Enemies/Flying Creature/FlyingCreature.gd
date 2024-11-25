extends Enemy

@onready var hitbox: Area2D = get_node("Hitbox")

@onready var player01: CharacterBody2D = get_tree().current_scene.get_node("Player")

const attack_distance: int = 30
const attack_distance_off: int = 2

var distance_to_player: float


func _on_PathTimer_timeout() -> void:
	if is_instance_valid(player):
		_get_path_to_player()
		distance_to_player = (player.position - global_position).length()
