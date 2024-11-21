extends FiniteStateMachine

@onready var player01: CharacterBody2D = get_tree().current_scene.get_node("Player")

func _init() -> void:
	_add_state("chase")
	_add_state("hurt")
	_add_state("dead")
	_add_state("attacking")
	
	
func _ready() -> void:
	set_state(states.chase)
	
	
func _state_logic(_delta: float) -> void:
	if state == states.chase:
		parent.chase()
		parent.move()
		
		
func _get_transition() -> int:
	match state:
		states.hurt:
			if not animation_player.is_playing():
				return states.chase
		states.attacking:
			if parent.distance_to_player > parent.attack_distance or parent.distance_to_player < parent.attack_distance_off:
				return states.chase
		states.chase:
			if parent.distance_to_player < parent.attack_distance and parent.distance_to_player > parent.attack_distance_off:
				return states.attacking
	return -1
	
	
func _enter_state(_previous_state: int, new_state: int) -> void:
	match new_state:
		states.chase:
			animation_player.play("fly")
		states.hurt:
			animation_player.play("hurt")
		states.dead:
			animation_player.play("dead")
		states.attacking:
			animation_player.play("attacking")
			
