extends Sprite2D


var speed_limit: float = 400
var friction: float = 0.1
var acceleration:float = 20

@onready var cannon = $cannon
var velocity = Vector2.ZERO

var projectile_container: Node

func set_projectile_container(container: Node):
	projectile_container = container
	cannon.projectile_container = container

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Player movement
	var direction:int = int(Input.is_action_pressed("move_rigth")) - int(Input.is_action_pressed("move_left"))
	
	if(direction != 0):
		velocity.x = clamp(velocity.x + (direction * acceleration), -speed_limit, speed_limit)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction) if abs(velocity.x) > 1 else 0
		
	position += velocity * delta
	
	#Cannon
	var mouse_position := get_global_mouse_position()
	cannon.look_at(mouse_position)
	
	if(Input.is_action_just_pressed("fire")):
		cannon.fire()
