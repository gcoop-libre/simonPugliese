# about_the_game.gd
extends RichTextLabel

signal textoCompleto

var page = 0
var textoDialog

func _ready():
	pass

func iniciar(_texto):
	textoDialog = _texto
	set_bbcode(textoDialog[page])
	set_visible_characters(0)

func _on_Timer_timeout():
	set_visible_characters(get_visible_characters()+1)
	if get_visible_characters() > get_total_character_count():
		if page < textoDialog.size()-1:
			page += 1
			append_bbcode(str("\n\n", textoDialog[page]))
		else:
			emit_signal("textoCompleto")