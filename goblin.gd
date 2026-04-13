extends RigidBody2D

var rotateam
var savedVelocity
var loggedhits = 0
var hittimer = 0
var hits = 0
var keys = []
var numcorrespond = ["a","s","d"]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var variations = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = variations.pick_random()
	if $CollisionShape2D.global_position.x > 89:
		$AnimatedSprite2D.flip_h = true
	$AnimatedSprite2D.play()
	savedVelocity = linear_velocity
	keys.append(numcorrespond[randi_range(0,2)])
	keys.append(numcorrespond[randi_range(0,2)])
	keys.append(numcorrespond[randi_range(0,2)])
	
	$Letter1.animation = (keys[0])
	$Letter2.animation = (keys[1])
	$Letter3.animation = (keys[2])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed(keys[2]) and hits == 2:
		queue_free()
	if Input.is_action_just_pressed(keys[1]) and hits == 1:
		hits = 2
	if Input.is_action_just_pressed(keys[0]) and hits == 0:
		hits = 1 
	if hittimer == 0:
		rotate(0)
		$AnimatedSprite2D.play("default")
		linear_velocity = savedVelocity
		$AnimatedSprite2D.rotate(-rotateam)
	if hits != loggedhits:
		rotateam = randi_range(-20,20)
		$AnimatedSprite2D.rotate(rotateam)
		$AnimatedSprite2D.play("hit")
		hittimer = 60
		linear_velocity = Vector2(0,0)
	loggedhits = hits
	if hittimer > 0:
		hittimer -= 1 
