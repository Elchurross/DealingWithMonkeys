extends KinematicBody2D

var health : int = 75
var gravity : int = 900
var speed : int = 150
var velocity : Vector2 =  Vector2.ZERO

onready var sprite : AnimatedSprite = get_node("Jordan")
onready var cooldown : Timer = get_node("Cooldown")
onready var attackTimer : Timer = get_node("AttackTimer")

var ready : bool = false
var target
var flip : bool = true

func _ready():
	cooldown.one_shot = true

func hurt(damage):
	if health <= damage:
		health = 0
		get_node("Jordan").play("dead")
		set_collision_layer_bit(0, false)
		set_collision_mask_bit(0, false)
	else:
		health -= damage
		cooldown.start(0.5)
		get_node("Jordan").play("hurt")

func _physics_process(delta):
	velocity.x = 0
	if !cooldown.is_stopped() or health <= 0:
		velocity = move_and_slide(velocity, Vector2.UP)
		velocity.y += gravity * delta
		return
	
	get_node("AttackArea/CollisionShape2D").disabled = true
	
	if target != null:
		if abs(target.position.x - position.x) > 50:
			attackTimer.stop();
			if target.position.x > position.x:
				velocity.x += speed
			else:
				velocity.x -= speed
		elif attackTimer.is_stopped():
			attackTimer.start(1);
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if velocity.x == 0:
		get_node("Jordan").play("idle")
	else:
		get_node("Jordan").play("walk")
	
	velocity.y += gravity * delta
	
	if target != null:
		if abs(target.position.x - position.x) < 50 and ready:
			get_node("AttackArea/CollisionShape2D").disabled = false
			get_node("Jordan").play("attack")
			cooldown.start(0.2)
			attackTimer.start(rand_range(0.5, 2.5))
			ready = false
	
	if velocity.x > 0:
		sprite.flip_h = false
		if !flip:
			get_node("AttackArea").scale.x *= -1
		flip = true
	elif velocity.x < 0:
		sprite.flip_h = true
		if flip:
			get_node("AttackArea").scale.x *= -1
		flip = false


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		target = body


func _on_AttackTimer_timeout():
	ready = true


func _on_AttackArea_body_entered(body):
	if body.is_in_group("Player"):
		body.hurt(20)
