extends KinematicBody2D

var health : int = 400
var gravity : int = 900
var speed : int = 190
var velocity : Vector2 =  Vector2.ZERO

onready var sprite : AnimatedSprite = get_node("Kevin")
onready var cooldown : Timer = get_node("Cooldown")
onready var attackTimer : Timer = get_node("AttackTimer")

var Box = preload("res://DialogBox.tscn")
const Biere = preload("res://Biere.tscn")
const Joints = preload("res://Joint.tscn")
const Gun = preload("res://Gun.tscn")

var ready : bool = false
var target
var flip : bool = true
var attack : bool = false
var player
var box
var talking = false
var playerNear = false
var used = false
var working = true

var dialog = ["HEY YOU", "YEAH! YOU!", "COME HERE SO I CAN KICK YOUR DIRTY ASS"]

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
		get_node("Death").play()
		
	else:
		health -= damage
		cooldown.start(0.5)
		get_node("Kevin").play("hurt")
		get_node("Hurt").play()

func _physics_process(delta):
	if (attack == true):
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
	else:
		get_node("Kevin").play("idle")
		if box == null and player != null and talking:
			print("6")
			player.talking = false
			talking = false
		if playerNear and !used:
			print("4")
			if !player.talking:
				print("5")
				player.talking = true
				talking = true
				box = Box.instance()
				box.position = get_node("NPC/Position2D").position - Vector2(300, 0)
				add_child(box)
				used = true
		if (used == true and talking == false):
			attack = true
			target = player
		
func _on_AttackArea_body_entered(body):
	if body.is_in_group("Player") and attack == true:
		body.hurt(20)
		
func _on_TriggerArea_body_entered(body):
	if body.is_in_group("Player") and attack == true:
		target = body

func _on_AttackTimer_timeout():
	ready = true

func _on_NPC_body_entered(body):
	print("1")
	if body.is_in_group("Player"):
		print("2")
		player = body
		playerNear = true

func _on_NPC_body_exited(body):
	if body.is_in_group("Player"):
		playerNear = false
