extends Area2D

var Box = preload("res://DialogBox.tscn")
var playerNear : bool = false
var box 
var player
var talking = true
const dialog = ["Rafiki: Hello, how are you?", "Kevin: i feel awful. By the way, who are you? And where am i?", "Rafiki: This morning i found you passed out, you're in my house", "Kevin: I don't remember what the hell i did yesterday", "Rafiki: if you want i can give you something to help you remember. But careful it's a litle bit expensive", "Kevin: Sure, i don't see why not. Thanks man!"]

func _process(_delta):
	if box == null and player != null and talking:
		player.talking = false
		talking = false
	if playerNear and Input.is_action_just_pressed("Interact"):
		if !player.talking:
			player.talking = true
			talking = true
			box = Box.instance()
			box.position = get_node("Position2D").position
			add_child(box)

func _on_NPC_body_entered(body):
	if body.is_in_group("Player"):
		player = body
		playerNear = true

func _on_NPC_body_exited(body):
	if body.is_in_group("Player"):
		playerNear = false
