extends KinematicBody2D

var health : int = 75
var gravity : int = 900
var speed : int = 150
var velocity : Vector2 =  Vector2.ZERO

onready var sprite : AnimatedSprite = get_node("Kevin")
onready var cooldown : Timer = get_node("Cooldown")
onready var attackTimer : Timer = get_node("AttackTimer")

const Biere = preload("res://Biere.tscn")
const Joints = preload("res://Joint.tscn")
const Gun = preload("res://Gun.tscn")

var ready : bool = false
var target
var flip : bool = true

func _ready():
	cooldown.one_shot = true

func hurt(damage):
	if health <= damage:
		health = 0
		get_node("Kevin").play("dead")
		set_collision_layer_bit(0, false)
		set_collision_mask_bit(0, false)
		randomize()
		var drop = rand_range(0, 10)
		print (drop)
		if drop <= 4:
			var biere = Biere.instance()
			get_parent().add_child(biere)
			biere.position = global_position
		elif drop <= 6:
			var joint = Joints.instance()
			get_parent().add_child(joint)
			joint.position = global_position
		elif drop <= 7:
			var gun = Gun.instance()
			get_parent().add_child(gun)
			gun.position = global_position
		
	else:
		health -= damage
		cooldown.start(0.5)
		get_node("Kevin").play("hurt")

func _physics_process(delta):
	velocity.x = 0
	get_node("AttackArea/CollisionShape2D").disabled = true
	if !cooldown.is_stopped() or health <= 0:
		velocity = move_and_slide(velocity, Vector2.UP)
		velocity.y += gravity * delta
		return
	
	
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
		get_node("Kevin").play("idle")
	else:
		get_node("Kevin").play("walk")
	
	velocity.y += gravity * delta
	
	if target != null:
		if abs(target.position.x - position.x) < 50 and ready:
			get_node("AttackArea/CollisionShape2D").disabled = false
			get_node("Kevin").play("punch")
			cooldown.start(0.2)
			attackTimer.start(rand_range(0.5, 2.5))
			ready = false
	
	if velocity.x > 0:
		sprite.flip_h = true
		if flip:
			get_node("AttackArea").scale.x *= -1
		flip = false
	elif velocity.x < 0:
		sprite.flip_h = false
		if !flip:
			get_node("AttackArea").scale.x *= -1
		flip = true
		
func _on_AttackArea_body_entered(body):
	print(body.get_groups())
	if body.is_in_group("Player"):
		body.hurt(20)
		
func _on_TriggerArea_body_entered(body):
	if body.is_in_group("Player"):
		target = body

func _on_AttackTimer_timeout():
	ready = true