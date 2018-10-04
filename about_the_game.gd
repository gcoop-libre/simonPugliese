# about_the_game.gd
extends RichTextLabel

signal textoCompleto

var texto = ["¡Bienvenidos, bienvenidas!", "Osvaldito Pugliese y los músicos quieren armar \nla orquesta y necesitan tu ayuda.", "Te proponemos un desafío ¿Te sumás?", "Prepará las antenas que vas a tener que repetir la melodía"]
var page = 0

func _ready():
	set_bbcode(texto[page])
	set_visible_characters(0)

func _on_Timer_timeout():
	set_visible_characters(get_visible_characters()+1)
	if get_visible_characters() > get_total_character_count():
		if page < texto.size()-1:
			page += 1
			append_bbcode(str("\n\n", texto[page]))
		else:
			emit_signal("textoCompleto")