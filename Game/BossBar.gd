extends KinematicBody2D

var maxHealth : int = 100
var health : int = maxHealth
var beer : int = 20
var gravity : int = 900
var speed : int = 50
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
		collision_layer = 0
		collision_mask = 0
	else:
		health -= damage
		cooldown.start(0.5)
		get_node("Kevin").play("hurt")

func _physics_process(delta):
	velocity.x = 0
	if !cooldown.is_stopped() or health <= 0:
		velocity.y += gravity * delta
		return
	
	velocity.y += gravity * delta

	var player = get_tree().get_nodes_in_group("Player")
	if (player[0].get_global_position().x > get_global_position().x):
		velocity.x = 1 * speed
		move_and_slide(velocity, Vector2.RIGHT)
		sprite.flip_h = true
		player
	else:
		velocity.x = -1 * speed
		move_and_slide(velocity, Vector2.LEFT)
		sprite.flip_h = false
	if velocity.x == 0:
		get_node("Kevin").play("idle")
	else:
		get_node("Kevin").play("walk")
		
