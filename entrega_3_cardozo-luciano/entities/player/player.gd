extends CharacterBody2D
class_name Player

var speed_limit: float = 400
var friction: float = 0.1
var acceleration:float = 20
const GRAVITY = 20
const JUMP_POWER = -500

@onready var cannon = $cannon

var projectile_container: Node

func set_projectile_container(container: Node):
	projectile_container = container
	cannon.projectile_container = container

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cannonBehaivor()
		
func _physics_process(delta: float) -> void:
	playerMovement()
	playerJump()
	
func playerJump():
	if(Input.is_action_just_pressed("jump") and self.is_on_floor()):
		velocity.y = JUMP_POWER
	
func playerMovement():
	var direction:int = int(Input.is_action_pressed("move_rigth")) - int(Input.is_action_pressed("move_left"))
	
	if(direction != 0):
		velocity.x = clamp(velocity.x + (direction * acceleration), -speed_limit, speed_limit)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction) if abs(velocity.x) > 1 else 0
	
	velocity.y += GRAVITY
	move_and_slide()
	
func cannonBehaivor():
	var mouse_position := get_global_mouse_position()
	cannon.look_at(mouse_position)
	
	if(Input.is_action_just_pressed("fire")):
		cannon.fire()
		
