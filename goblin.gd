extends RigidBody2D

var hits
var keys = []
var numcorrespond = ["A","S","D"]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var variations = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = variations.pick_random()
	if $CollisionShape2D.global_position.x > 89:
		$AnimatedSprite2D.flip_h = true
	$AnimatedSprite2D.play()
	keys.append(numcorrespond[randi_range(0,2)])
	keys.append(numcorrespond[randi_range(0,2)])
	keys.append(numcorrespond[randi_range(0,2)])
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed(keys[0]):
		hits = 1 
	if Input.is_action_pressed(keys[1]) and hits == 1:
		hits = 2 
	if Input.is_action_pressed(keys[2]) and hits == 2:
		queue_free()
