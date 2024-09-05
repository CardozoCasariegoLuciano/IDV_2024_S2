extends StaticBody2D
class_name Torreta

@onready var firePosition:Marker2D = $Marker2D
@onready var fireTimer:Timer = $Timer

@export var projectile_scene: PackedScene
var projectile_container: Node
var target: CharacterBody2D
var screen_size: Vector2

func _ready() -> void:
	screen_size = get_viewport_rect().size
	
func _physics_process(delta):
	if(target):
		var space_state = get_world_2d().direct_space_state
		var query = PhysicsRayQueryParameters2D.create(global_position, target.global_position)
		var result = space_state.intersect_ray(query)
		
		var collider = result.get("collider")
		if  collider is Player or collider is Torreta:
			fireTimer.paused
		else:
			fireTimer.start()
			

func set_values(projectile_container: Node, position_x: int,  position_y: int,):
	self.projectile_container = projectile_container
	position.x = position_x
	position.y = position_y

func _on_timer_timeout() -> void:
	if(target != null):
		var projectile_instance:Abstract_projectible = projectile_scene.instantiate()
		projectile_container.add_child(projectile_instance)
		projectile_instance.set_starting_values(firePosition.global_position, (target.global_position - firePosition.global_position).normalized())



func _on_area_2d_body_entered(body: Node2D) -> void:
	if(target == null):
		target = body
		fireTimer.start()

func _on_area_2d_body_exited(body: Node2D) -> void:
	target = null
	fireTimer.paused
