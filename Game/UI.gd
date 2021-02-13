extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var number_label_hp = get_node("HBoxContainer/Bars/Bar/HPCount/Background/Number")
	var number_label_tesson = get_node("HBoxContainer/Counters/TESSONCount2/Background/Number")
	var number_label_ammo = get_node("HBoxContainer/AMMOCount/Count2/Background/Number")
	var bar = get_node("HBoxContainer/Bars/Bar/Gauge")
	var player = get_owner().get_node("Player")
	bar.max_value = player.maxHealth
	bar.value = player.health
	number_label_hp.text = str(player.maxHealth)
	number_label_tesson.text = str(player.tesson)
	number_label_ammo.text = str(player.ammo)
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var number_label_hp = get_node("HBoxContainer/Bars/Bar/HPCount/Background/Number")
	var number_label_tesson = get_node("HBoxContainer/Counters/TESSONCount2/Background/Number")
	var bar = get_node("HBoxContainer/Bars/Bar/Gauge")
	var number_label_ammo = get_node("HBoxContainer/AMMOCount/Count2/Background/Number")
	var player = get_owner().get_node("Player")

	bar.value = player.health
	number_label_hp.text = str(player.maxHealth)
	number_label_tesson.text = str(player.tesson)
	number_label_ammo.text = str(player.ammo)
	pass
