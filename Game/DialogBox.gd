extends Polygon2D

var page : int = 0
onready var text = get_node("RichTextLabel")
onready var dialog = get_parent().dialog

func _ready():
	text.set_bbcode(dialog[page])
	text.set_visible_characters(0)

func _process(_delta):
	if Input.is_action_just_pressed("Interact"):
		if text.get_visible_characters() >= text.get_total_character_count():
			if page < dialog.size() - 1:
				page += 1
				text.set_bbcode(dialog[page])
				text.set_visible_characters(0)
			else:
				queue_free()
		else:
			text.set_visible_characters(text.get_total_character_count())

func _on_Timer_timeout():
	text.set_visible_characters(text.get_visible_characters() + 1)
