extends Node

@onready var scoreTime = $ScoreTimer
@onready var mobtimer =$MobTimer
@onready var player = $Player
@onready var startTimer =$StartTimer
@onready var startPosition =$StartPosition


@export var mob_scene: PackedScene
var score

func game_over() -> void:
	scoreTime.stop()
	mobtimer.stop()
	$HUD.show_game_over()
	$music.stop()
	$deadSound.play()
	
func new_game():
	score = 0
	player.start(startPosition.position)
	startTimer.start()
	get_tree().call_group("mobs", "queue_free")
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$music.play()
	
func _on_start_timer_timeout() -> void:
	mobtimer.start()
	scoreTime.start()

func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)

func _on_mob_timer_timeout() -> void:
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
