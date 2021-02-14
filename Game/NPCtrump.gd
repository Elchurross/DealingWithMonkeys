extends Area2D

var Box = preload("res://DialogBox.tscn")
const Biere = preload("res://Biere.tscn")
var playerNear : bool = false
var box 
var player
var talking = true
var used = false
var working = true
var dialog = ["Hey i am Donald Trump","I would say that Poutine is a (way) more pleasant man than me","But today, I will prove that it is not the case!","So, you can have all my wine!"]

func _process(_delta):
	if box == null and player != null and talking:
		player.talking = false
		talking = false
	if playerNear and Input.is_action_just_pressed("Interact"):
		if !player.talking:
			player.talking = true
			talking = true
			box = Box.instance()
			box.position = get_node("Position2D").position - Vector2(55, 0)
			add_child(box)
			used = true

	if (used == true and talking == false and working == true):
		var biere = Biere.instance()
		var biere2 = Biere.instance()
		var biere3 = Biere.instance()
		var biere4 = Biere.instance()
		var biere5 = Biere.instance()
		var biere6 = Biere.instance()
		var biere7 = Biere.instance()
		var biere8 = Biere.instance()
		var biere9 = Biere.instance()
		var biere10 = Biere.instance()
		var biere11 = Biere.instance()
		var biere12 = Biere.instance()
		var biere13 = Biere.instance()
		var biere14 = Biere.instance()
		var biere15 = Biere.instance()
		get_parent().call_deferred("add_child", biere)
		get_parent().call_deferred("add_child", biere2)
		get_parent().call_deferred("add_child", biere3)
		get_parent().call_deferred("add_child", biere4)
		get_parent().call_deferred("add_child", biere5)
		get_parent().call_deferred("add_child", biere7)
		get_parent().call_deferred("add_child", biere8)
		get_parent().call_deferred("add_child", biere9)
		get_parent().call_deferred("add_child", biere10)
		get_parent().call_deferred("add_child", biere11)
		get_parent().call_deferred("add_child", biere12)
		get_parent().call_deferred("add_child", biere13)
		get_parent().call_deferred("add_child", biere14)
		get_parent().call_deferred("add_child", biere15)
		biere.position = global_position + Vector2(20, 0)
		biere2.position = global_position + Vector2(25, 0)
		biere3.position = global_position - Vector2(20, 0)
		biere4.position = global_position + Vector2(20, 0)
		biere5.position = global_position+ Vector2(15, 0)
		biere6.position = global_position - Vector2(10, 0)
		biere7.position = global_position + Vector2(10, 0)
		biere8.position = global_position+ Vector2(35, 0)
		biere9.position = global_position - Vector2(30, 0)
		biere10.position = global_position + Vector2(30, 0)
		biere11.position = global_position+ Vector2(40, 0)
		biere12.position = global_position - Vector2(40, 0)
		biere13.position = global_position + Vector2(40, 0)
		biere14.position = global_position+ Vector2(50, 0)
		biere15.position = global_position - Vector2(20, 0)
		used = false
		working = false
		dialog = ["Now fuck off."]

func _on_NPC_body_entered(body): 
	if body.is_in_group("Player"):
		player = body
		playerNear = true

func _on_NPC_body_exited(body):
	if body.is_in_group("Player"):
		playerNear = false
