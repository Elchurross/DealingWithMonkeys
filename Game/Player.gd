extends KinematicBody2D

var maxHealth : int = 100
var health : int = maxHealth
var beer : int = 20

var speed : int = 200
var jumpForce : int = 420
var gravity : int = 900
var velocity : Vector2 =  Vector2.ZERO
var flip : bool = false

onready var sprite : AnimatedSprite = get_node("Kevin")

var jumping : bool = false
var ammo : int = 0
var tesson : int = 5
var maxTesson : int = 10

var cooldown : int = 0

var Bullet = preload("res://Bullet.tscn")

func drinkBeer():
	get_node("Kevin").play("drink")
	health = maxHealth if health + beer > maxHealth else health + beer
	cooldown = 40
	tesson = maxTesson if tesson + 1 > maxTesson else tesson + 1
	
func addAmmo(ammount):
	ammo += ammount

func hurt(damage):
	if health <= damage:
		health = 0
		get_node("Kevin").play("dead")
	else:
		health -= damage
		get_node("Kevin").play("hurt")

func _physics_process(delta):
	velocity.x = 0
	if cooldown > 0:
		velocity = move_and_slide(velocity, Vector2.UP)
		velocity.y += gravity * delta
		cooldown -= 1
		return
	
	if  Input.is_action_pressed("move_left"):
		velocity.x -= speed
	elif Input.is_action_pressed("move_right"):
		velocity.x += speed
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if is_on_floor():
		jumping = false
		if velocity.x == 0:
			if ammo <= 0:
				get_node("Kevin").play("idle")
			else:
				get_node("Kevin").play("idle_gun")
		else:
			if ammo <= 0:
				get_node("Kevin").play("walk")
			else:
				get_node("Kevin").play("walk_gun")
	
	velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= jumpForce
		get_node("Kevin").play("jump")
		jumping	= true
	if !is_on_floor() and !jumping:
		get_node("Kevin").play("fall")
	
	if Input.is_action_just_pressed("punch"):
		if ammo == 0:
			get_node("Kevin").play("punch")
			cooldown = 10
		else:
			var bullet = Bullet.instance(true)
			bullet.direction = flip
			owner.add_child(bullet)
			bullet.transform = get_node("Kevin").global_transform
			ammo -= 1
	
	if velocity.x < 0:
		sprite.flip_h = true
		flip = true
	elif velocity.x > 0:
		sprite.flip_h = false
		flip = false
	
