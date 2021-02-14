extends Area2D

var Box = preload("res://DialogBox.tscn")
var playerNear : bool = false
var box 
var player
var talking = true
const dialog = ["nice to see you", "here is another test line", "yes, i'm a dealer gorilla, you are not halucinating", "Goodbye World?"]

func _process(_delta):
	if box == null and player != null and talking:
		player.talking = false
		talking = false
	if playerNear and Input.is_action_just_pressed("Interact"):
		if !player.talking:
			get_node("AudioBop").play()
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
