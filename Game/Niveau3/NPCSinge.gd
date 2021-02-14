extends Area2D

var Box = preload("res://DialogBox.tscn")
var playerNear : bool = false
var box 
var player
var used = false
var working = true
var talking = true
export var reference_path = ""
const dialog = ["Rafiki: Kevin... Kevin... Kevin...", "We spent some great time together, right?", "Kevin: Yeah, i guess *Hips* so.", "What d'you want?", "Rafiki: I see that you are way too drunk to understand anything.", "Let's say that you saw something that you should have never seen", "Kevin: YOUR MASSIVE DI..?!", "Rafiki: Imma gonna stop you right there 'cause..."]

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
			used = true

	if (used == true and talking == false and working == true):
		get_tree().change_scene(reference_path) 

func _on_NPC_body_entered(body):
	if body.is_in_group("Player"):
		player = body
		playerNear = true

func _on_NPC_body_exited(body):
	if body.is_in_group("Player"):
		playerNear = false
