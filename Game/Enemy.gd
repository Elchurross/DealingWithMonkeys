extends KinematicBody2D

var maxHealth : int = 100
var health : int = maxHealth
var beer : int = 20
var gravity : int = 900
var speed : int = 200
var velocity : Vector2 =  Vector2.ZERO
var flip : bool = false

onready var sprite : AnimatedSprite = get_node("Kevin")
onready var cooldown : Timer = get_node("Cooldown")

var ammo : int = 0
var tesson : int = 5
var maxTesson : int = 10


func _ready():
	cooldown.one_shot = true

func hurt(damage):
	if health <= damage:
		health = 0
		get_node("Kevin").play("dead")
	else:
		health -= damage
		cooldown.start(0.5)
		get_node("Kevin").play("hurt")
		get_node("CollisionShape2D").disabled = true

func _physics_process(delta):
	velocity.x = 0
	if !cooldown.is_stopped() or health <= 0:
		velocity.y += gravity * delta
		return
	
	velocity.y += gravity * delta
	get_node("Kevin").play("joint")
	
	if velocity.x < 0:
		sprite.flip_h = true
		flip = true
	elif velocity.x > 0:
		sprite.flip_h = false
		flip = false
