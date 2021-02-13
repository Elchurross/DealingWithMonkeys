extends Area2D

var maxHealth : int = 100
var health : int = maxHealth
var beer : int = 20

var speed : int = 200
var velocity : Vector2 =  Vector2.ZERO
var flip : bool = false

onready var sprite : AnimatedSprite = get_node("Kevin")

var ammo : int = 0
var tesson : int = 5
var maxTesson : int = 10

var cooldown : int = 0

func hurt(damage):
	if health <= damage:
		health = 0
		get_node("Kevin").play("dead")
	else:
		health -= damage
		get_node("Kevin").play("hurt")

func _physics_process(delta):
	velocity.x = 0
	if cooldown > 0 or health <= 0:
		velocity.y += gravity * delta
		cooldown -= 1
		return
	
	velocity.y += gravity * delta
	
	if velocity.x < 0:
		sprite.flip_h = true
		flip = true
	elif velocity.x > 0:
		sprite.flip_h = false
		flip = false

func _on_Ennemy_area_entered(area):
	if area.is_in_group("Punch"):
		hurt(20)
	if area.is_in_group("Bullet"):
		hurt(40)
		area.free()
