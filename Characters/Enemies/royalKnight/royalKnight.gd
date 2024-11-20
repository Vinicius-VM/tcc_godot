extends Enemy

const THROWABLE_KNIFE_SCENE: PackedScene = preload("res://Characters/Enemies/royalKnight/ThrowableKnife.tscn")

const MAX_DISTANCE_TO_PLAYER1: int = 20
const MIN_DISTANCE_TO_PLAYER1: int = 5

@export var projectile_speed1: int = 150

@onready var sword: Node2D = get_node("sword")

var can_attack: bool = true

var distance_to_player: float

@onready var attack_timer: Timer = get_node("AttackTimer")
@onready var aim_raycast: RayCast2D = get_node("AimRayCast")
@onready var projectileTimer: Timer = get_node("projectile_timer")

#func _ready():
	# Connect the timeout signal of the projectileTimer to the _on_projectileTimer_timeout method
	#projectileTimer.connect("timeout", self, "_on_projectileTimer_timeout")

func _on_PathTimer_timeout() -> void:
	if is_instance_valid(player):
		distance_to_player = (player.position - global_position).length()
		if distance_to_player > MAX_DISTANCE_TO_PLAYER1:
			_get_path_to_player()
		elif distance_to_player < MIN_DISTANCE_TO_PLAYER1:
			_get_path_to_move_away_from_player()
		else:
			aim_raycast.target_position = player.position - global_position
			if can_attack and state_machine.state == state_machine.states.idle and not aim_raycast.is_colliding():
				can_attack = false
				attack()
				attack_timer.start()
		var aim_direction: Vector2 = (player.position - global_position).normalized()
		
	else:
		mov_direction = Vector2.ZERO


func _get_path_to_move_away_from_player() -> void:
	var dir: Vector2 = (global_position - player.position).normalized()
	navigation_agent.target_position = global_position + dir * 100


var projectile: Area2D = THROWABLE_KNIFE_SCENE.instantiate()
func attack() -> void:
	projectile = THROWABLE_KNIFE_SCENE.instantiate()
	projectile.launch(global_position, (player.position - global_position).normalized(), projectile_speed1)
	get_tree().current_scene.add_child(projectile)
	
	projectileTimer.start()

func _on_projectileTimer_timeout():
	# When the timer times out, remove the projectile from the scene
	projectile.queue_free()

func _on_AttackTimer_timeout() -> void:
	can_attack = true
