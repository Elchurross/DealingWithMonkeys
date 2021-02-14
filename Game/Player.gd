extends KinematicBody2D

var maxHealth : int = 100
var health : int = maxHealth
var beer : int = 10

var speed : int = 200
var jumpForce : int = 420
var gravity : int = 900
var velocity : Vector2 =  Vector2.ZERO
var flip : bool = false

onready var sprite : AnimatedSprite = get_node("Kevin")
onready var cooldown : Timer = get_node("Cooldown")
onready var boost : Timer = get_node("Boost")
export var reference_path = ""
var jumping : bool = false
var talking : bool = false
var dead : bool = false
const Bullet = preload("res://Bullet.tscn")
var ammo : int = 0
var tesson : int = 5
const Tesson = preload("res://Tesson.tscn")
var maxTesson : int = 100
var cdAttack = 0
var inCd = false

func _ready():
	cooldown.one_shot = true
	boost.one_shot = true

func smokeJoint():
	get_node("Kevin").play("joint")
	get_node("AudioJoint").play()
	cooldown.start(0.5)
	boost.stop()
	boost.start(100)

func drinkBeer():
	get_node("Kevin").play("drink")
	get_node("AudioDrink").play()
	health = maxHealth if health + beer > maxHealth else health + beer
	cooldown.start(0.3)
	tesson = maxTesson if tesson + 1 > maxTesson else tesson + 1
	
func addAmmo(ammount):
	get_node("AudioPickupGun").play()
	ammo += ammount

func hurt(damage):
	if health <= damage:
		health = 0
		get_node("Kevin").play("dead")
		if !dead:
			get_node("AudioDeath").play()
			dead = true
	else:
		health -= damage
		cooldown.start(0.5)
		get_node("Kevin").play("hurt")
		get_node("AudioHurt").play()

func _physics_process(delta):
	if (inCd == true):
		cdAttack += delta
	if (cdAttack >= 0.6):
		cdAttack = 0
		inCd = false
	velocity.x = 0
	if !cooldown.is_stopped() or health <= 0 or talking:
		if talking:
			get_node("Kevin").play("idle")
		velocity = move_and_slide(velocity, Vector2.UP)
		velocity.y += gravity * delta
		return
	
	get_node("PunchArea/CollisionShape2D").disabled = true
	
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
	
	if Input.is_action_just_pressed("punch") and inCd == false:
		if ammo == 0:
			get_node("PunchArea/CollisionShape2D").disabled = false
			get_node("Kevin").play("punch")
			get_node("AudioPunch").play()
			cooldown.start(0.1)
			inCd = true
			
			
		else:
			var bullet = Bullet.instance()
			bullet.direction = flip
			get_parent().add_child(bullet)
			if !flip:
				bullet.position = get_node("PosShootRight").global_position
			else:
				bullet.position = get_node("PosShootLeft").global_position
			get_node("AudioGun").play()
			ammo -= 1
	
	if Input.is_action_just_pressed("throw") and tesson > 0:
		get_node("Kevin").play("punch")
		get_node("AudioThrow").play()
		cooldown.start(0.2)
		var t = Tesson.instance()
		t.direction = flip
		if !boost.is_stopped():
			t.boost = true
		get_parent().add_child(t)
		if !flip:
			t.position = get_node("PosShootRight").global_position
		else:
			t.position = get_node("PosShootLeft").global_position
		tesson -= 1
	
	if velocity.x < 0:
		if !flip:
			sprite.flip_h = true
			get_node("PunchArea").scale.x *= -1
		flip = true
	elif velocity.x > 0:
		if flip:
			sprite.flip_h = false
			get_node("PunchArea").scale.x *= -1
		flip = false

func _on_PunchArea_body_entered(body):
	if body.is_in_group("Ennemy"):
		if boost.is_stopped():
			body.hurt(20)
		else:
			body.hurt(40)
