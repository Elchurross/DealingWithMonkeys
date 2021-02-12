extends KinematicBody2D

var score : int = 0

var speed : int = 200
var jumpForce : int = 420
var gravity : int = 900
var velocity : Vector2 =  Vector2.ZERO

onready var sprite : AnimatedSprite = get_node("Kevin")

func _physics_process(delta):
	velocity.x = 0
	
	if  Input.is_action_pressed("move_left"):
		velocity.x -= speed
	elif Input.is_action_pressed("move_right"):
		velocity.x += speed
	
	if velocity.x == 0:
		get_node("Kevin").stop()
		get_node("Kevin").play("idle")
	else:
		get_node("Kevin").play("walk")
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	
	velocity.y += gravity * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= jumpForce
	
	if velocity.x < 0:
		sprite.flip_h = true
	elif velocity.x > 0:
		sprite.flip_h = false
