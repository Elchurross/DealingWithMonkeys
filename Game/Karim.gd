extends KinematicBody2D

var health : int = 600
var gravity : int = 900
var speed : int = 150
var velocity : Vector2 =  Vector2.ZERO
var dead : bool = false

onready var sprite : AnimatedSprite = get_node("karim")
onready var cooldown : Timer = get_node("Cooldown")
onready var attackTimer : Timer = get_node("AttackTimer")

const Joints = preload("res://Joint.tscn")
const Cola = preload("res://Cola.tscn")

var ready : bool = false
var target

var Box = preload("res://DialogBox.tscn")
var box
const dialog = ["Karim: YO, how are you doing?", "Karim: I finally understand why you have failed all your projects", "Karim: you need a good beat up"]
var talking : bool = false

func _ready():
	cooldown.one_shot = true

func hurt(damage):
	if health <= damage:
		health = 0
		get_node("karim").play("dead")
		set_collision_layer_bit(0, false)
		set_collision_mask_bit(0, false)
		var joint = Joints.instance()
		get_parent().call_deferred("add_child", joint)
		joint.position = global_position
		if !dead:
			get_node("AudioDeath").play()
			dead = true
	else:
		health -= damage
		cooldown.start(0.5)
		get_node("karim").play("hurt")
		get_node("AudioHurt").play()

func _physics_process(delta):
	velocity.x = 0
	if !cooldown.is_stopped() or health <= 0 or talking:
		velocity = move_and_slide(velocity, Vector2.UP)
		velocity.y += gravity * delta
		if box == null and target != null:
			target.talking = false
			talking = false
		return
	
	if target != null:
		var dist = abs(target.position.x - position.x)
		if dist < 400 or dist > 500:
			attackTimer.stop();
			if dist < 400:
				velocity.x += speed
			elif dist > 500:
				velocity.x -= speed
		elif attackTimer.is_stopped():
			attackTimer.start(0.3);
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if velocity.x == 0:
		get_node("karim").play("idle")
	else:
		get_node("karim").play("walk")
	velocity.y += gravity * delta
	
	if target != null:
		if ready:
			get_node("karim").play("attack")
			cooldown.start(0.2)
			attackTimer.start(rand_range(0.2, 1.5))
			ready = false
			var cola = Cola.instance()
			if target.position.x < position.x:
				cola.direction = true
				cola.position = get_node("PosShootLeft").global_position
			else:
				cola.direction = false
				cola.position = get_node("PosShootRight").global_position
			get_parent().add_child(cola)
			get_node("AudioThrow").play()
	
	if velocity.x > 0:
		sprite.flip_h = true
	elif velocity.x < 0:
		sprite.flip_h = false

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player") and target == null:
		get_node("AudioBop").play()
		target = body
		talking = true
		body.talking = true
		box = Box.instance()
		box.position = get_node("Position2D").position
		add_child(box)


func _on_AttackTimer_timeout():
	ready = true

func _on_VisibilityNotifier2D_screen_exited():
	if health <= 0:
		queue_free()
