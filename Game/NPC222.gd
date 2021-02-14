extends Area2D

var Box = preload("res://DialogBox.tscn")
var playerNear : bool = false
var box 
var player
var talking = true
var used = false
export var reference_path = ""
var working = true
const dialog = ["Rafiki: You're back, do you rememeber what you did yesterday?", "Kevin: Yes, your stuff is amazing!", "Rafiki: Good, i recently got something new, do you want to test it.", "Kevin: Hell yeah! I want to try everything you have."]

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
		get_tree().change_scene(reference_path) 

func _on_NPC_body_entered(body):
	if body.is_in_group("Player"):
		player = body
		playerNear = true

func _on_NPC_body_exited(body):
	if body.is_in_group("Player"):
		playerNear = false
