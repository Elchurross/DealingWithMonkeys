extends KinematicBody2D

var health : int = 75
var gravity : int = 900
var speed : int = 200
var velocity : Vector2 =  Vector2.ZERO

onready var sprite : AnimatedSprite = get_node("Jordan")
onready var cooldown : Timer = get_node("Cooldown")

func _ready():
	cooldown.one_shot = true

func hurt(damage):
	if health <= damage:
		health = 0
		get_node("Jordan").play("dead")
		collision_layer = 0
		collision_mask = 0
	else:
		health -= damage
		cooldown.start(0.5)
		get_node("Jordan").play("hurt")

func _physics_process(delta):
	velocity.x = 0
	if !cooldown.is_stopped() or health <= 0:
		velocity.y += gravity * delta
		return
	
	velocity.y += gravity * delta
	get_node("Jordan").play("idle")
	
	if velocity.x < 0:
		sprite.flip_h = true
	elif velocity.x > 0:
		sprite.flip_h = false
