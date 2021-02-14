extends Area2D

var Box = preload("res://DialogBox.tscn")
const Biere = preload("res://Biere.tscn")
var playerNear : bool = false
var box 
var player
var talking = true
var used = false
var working = true
var dialog = ["Hey mate!", "I bet you wanna drink some beer with me.", "As my good friend Diogenes 'The Cynic' would say, what I like to drink most is wine that belongs to others", "Here you go then!"]

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
		get_parent().call_deferred("add_child", biere)
		get_parent().call_deferred("add_child", biere2)
		get_parent().call_deferred("add_child", biere3)
		biere.position = global_position + Vector2(20, 0)
		biere2.position = global_position
		biere3.position = global_position - Vector2(20, 0)
		used = false
		working = false
		dialog = ["As my good friend Diogenes 'The Cynic' would say, what I like to drink most is wine that belongs to others"]

func _on_NPC_body_entered(body):
	if body.is_in_group("Player"):
		player = body
		playerNear = true

func _on_NPC_body_exited(body):
	if body.is_in_group("Player"):
		playerNear = false
