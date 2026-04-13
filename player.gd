extends Area2D

signal hit

var screen_size
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("a") or Input.is_action_pressed("s") or Input.is_action_pressed("d"):
		$AnimatedSprite2D.play("attack")
	else:
		$AnimatedSprite2D.play("idle")

func _on_body_entered(_body):
	hit.emit()
