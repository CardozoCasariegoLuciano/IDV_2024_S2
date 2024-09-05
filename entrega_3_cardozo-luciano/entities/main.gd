extends Node

@onready var player = $Player
@export var torretas_scens: PackedScene

const CANT_TORRETAS = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.set_projectile_container(self)
	
	for i in $TurretSpawner.get_children():
		generateTurretsInArea(i)
	
func generateTurretsInArea(i: Area2D):
	var collitinShape = i.get_node("CollisionShape2D")
	var shape = collitinShape.shape
	var area = shape.size

	for cant in range(CANT_TORRETAS):
		var random_x = randf_range(-area.x / 2, area.x / 2)
		var random_y = randf_range(-area.y / 2, area.y / 2)
		var torreta_instance:Torreta = torretas_scens.instantiate()
		collitinShape.add_child(torreta_instance)
		torreta_instance.set_values(self, random_x, random_y)
