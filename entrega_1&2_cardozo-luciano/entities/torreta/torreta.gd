extends Sprite2D
class_name Torreta

@onready var firePosition:Marker2D = $Marker2D
@export var projectile_scene: PackedScene
var projectile_container: Node
var player: Sprite2D
var screen_size: Vector2
const player_min_distance = 200

func _ready() -> void:
	screen_size = get_viewport_rect().size

func set_values(player: Node, projectile_container: Node):
	self.projectile_container = projectile_container
	self.player = player
	set_random_position()
	$Timer.start()
	

func _on_timer_timeout() -> void:
	var projectile_instance:Abstract_projectible = projectile_scene.instantiate()
	projectile_container.add_child(projectile_instance)
	projectile_instance.set_starting_values(firePosition.global_position, (player.global_position - firePosition.global_position).normalized())

func set_random_position():
	var player_y = player.position.y
	position.x = randi_range(0, screen_size.x)
	position.y = randf_range(0, player_y - player_min_distance)
	
	
	
	
	
	
	
	
	
	
	
