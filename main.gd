extends Node

@export var goblin_scene : PackedScene
var score
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("A"):
		$Button_A.play("pressed")
	else:
		$Button_A.play("default")
		
	if Input.is_action_pressed("S"):
		$Button_S.play("pressed")
	else:
		$Button_S.play("default")
		
	if Input.is_action_pressed("D"):
		$Button_D.play("pressed")
	else:
		$Button_D.play("default")

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	
func new_game():
	score = 0
	$MobTimer.start()


func _on_mob_timer_timeout():
	var goblin = goblin_scene.instantiate()
	var spawn_location = $GoblinPath/GoblinSpawn
	spawn_location.progress_ratio = randf()
	
	goblin.position = spawn_location.position
	var direction = goblin.global_position.direction_to($StartPosition.global_position)
	var velocity = Vector2(20,0)
	goblin.linear_velocity = velocity.rotated(direction.angle())
	
	add_child(goblin)
	
func _on_score_timer_timeout():
	score += 1
