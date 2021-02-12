extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var number_label = get_node("HBoxContainer/Bars/Bar/HPCount/Background/Number")
	var bar = get_node("HBoxContainer/Bars/Bar/Gauge")
	var player = get_owner().get_node("Player")
	bar.max_value = player.maxHealth
	bar.value = player.health
	number_label.text = str(player.maxHealth)
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
