extends Sprite2D

@onready var firePosition:Marker2D = $FirePosition
@export var projectile_scene: PackedScene
var projectile_container: Node

func fire():
	var projectile_instance:Abstract_projectible = projectile_scene.instantiate()
	projectile_container.add_child(projectile_instance)
	projectile_instance.set_starting_values(firePosition.global_position, (firePosition.global_position - global_position).normalized())
