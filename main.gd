extends Node

@export var goblin_scene : PackedScene
var score
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$background.play("Start_game")
	$Player.hide()
	$Button_A.hide()
	$Button_D.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("a"):
		$Button_A.play("pressed")
	else:
		$Button_A.play("default")
		
	if Input.is_action_pressed("s"):
		$Button_S.play("pressed")
	else:
		$Button_S.play("default")
		
	if Input.is_action_pressed("d"):
		$Button_D.play("pressed")
	else:
		$Button_D.play("default")
	if Input.is_action_pressed("s") and $background.get_animation() == "Start_game":
		$background.play("GameMenu")
		$Button_A.show()
		$Button_D.show()
		$Player.show()
	if Input.is_action_pressed("a") and $background.get_animation() == "GameMenu":
		new_game()
	if Input.is_action_pressed("d") and $background.get_animation() == "GameMenu":
		get_tree().quit()
		
func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$background.play("GameMenu")
	get_tree().call_group("mobs", "queue_free")
	
	
func new_game():
	score = 0
	$MobTimer.start()
	$background.play("Game")


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
