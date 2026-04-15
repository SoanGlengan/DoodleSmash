extends RigidBody2D

var rotateam = 0
var savedVelocity
var loggedhits = 0
var hittimer = 0
var hits = 0
var keys = []
var numcorrespond = ["a","s","d"]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var variations = Array($AnimatedSprite2D.sprite_frames.get_animation_names()) 
	if $CollisionShape2D.global_position.x > 89:
		$AnimatedSprite2D.flip_h = true
	$AnimatedSprite2D.play("default")
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
		$Letter2.animation = (keys[1]+"(used)")
	if Input.is_action_just_pressed(keys[0]) and hits == 0:
		hits = 1 
		$Letter1.animation = (keys[0]+"(used)")
	if hittimer == 1:
		rotate(0)
		$AnimatedSprite2D.play("default")
		linear_velocity = savedVelocity
		$AnimatedSprite2D.rotation = 0
	if hits != loggedhits:
		rotateam = randi_range(-20,20)
		$AnimatedSprite2D.rotation_degrees = 0
		$AnimatedSprite2D.rotation_degrees = rotateam
		$AnimatedSprite2D.play("hit")
		hittimer = 60
		linear_velocity = Vector2(0,0)
	loggedhits = hits
	if hittimer > 0:
		hittimer -= 1 
