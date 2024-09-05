extends Sprite2D
class_name Abstract_projectible

var direction: Vector2
var screen_size: Vector2
@export var speed:= 50

func _ready() -> void:
	screen_size = get_viewport_rect().size
	set_physics_process(false)
	
func set_starting_values(starting_position: Vector2, direction: Vector2):
	global_position = starting_position
	self.direction = direction
	set_physics_process(true)

func _physics_process(delta: float) -> void:
	position += direction * delta * speed

func _on_clean_time_timeout() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("destruible"):
		body.queue_free()
	queue_free()
