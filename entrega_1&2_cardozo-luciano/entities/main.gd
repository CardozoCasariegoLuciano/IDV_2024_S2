extends Node

@onready var player = $Player
@export var torretas_scens: PackedScene

const CANT_TORRETAS = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.set_projectile_container(self)
	
	for i in range(CANT_TORRETAS):
		var torreta_instance:Torreta = torretas_scens.instantiate()
		add_child(torreta_instance)
		torreta_instance.set_values(player, self)
