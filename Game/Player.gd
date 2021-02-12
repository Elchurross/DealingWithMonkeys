extends KinematicBody2D

var maxHealth : int = 100
var health : int = maxHealth
var beer : int = 20

var speed : int = 200
var jumpForce : int = 420
var gravity : int = 900
var velocity : Vector2 =  Vector2.ZERO

onready var sprite : AnimatedSprite = get_node("Kevin")

var jumping : bool = false

func drinkBeer():
	get_node("Kevin").play("drink")
	health = maxHealth if health + beer > maxHealth else health + beer

func hurt(damage):
	if health <= damage:
		health = 0
		get_node("Kevin").play("dead")
	else:
		health -= damage
		get_node("Kevin").play("hurt")

func _physics_process(delta):
	velocity.x = 0
	
	if  Input.is_action_pressed("move_left"):
		velocity.x -= speed
	elif Input.is_action_pressed("move_right"):
		velocity.x += speed
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if is_on_floor():
		jumping = false
		if velocity.x == 0:
			get_node("Kevin").play("idle")
		else:
			get_node("Kevin").play("walk")
	
	velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= jumpForce
		get_node("Kevin").play("jump")
		jumping	= true
	if !is_on_floor() and !jumping:
		get_node("Kevin").play("fall")
	
	if velocity.x < 0:
		sprite.flip_h = true
	elif velocity.x > 0:
		sprite.flip_h = false
	
