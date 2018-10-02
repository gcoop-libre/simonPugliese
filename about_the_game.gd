# about_the_game.gd
extends RichTextLabel

signal textoCompleto

var texto = ["Simón - Pugliese es un juego educativo para probar el ingenio, los reflejos y la memoria.", "Está pensado para niños y niñas de entre 6 y 10 años y se juega de forma individual.", "El objetivo es conformar la orquesta de Osvaldo Pugliese y sus músicos.",  "Para ello hay que pasar una serie de niveles en los cuales deberán repetir melodías en un teclado virtual y resolver laberintos.", "En cada jugada se mostrará una melodía nueva que se tendrá que repetir siempre desde el principio y en el mismo orden formando una cadena de sonidos, para ello hay que tocar la tecla adecuada.", "A continuación se deberá atravesar un laberinto para conseguir los instrumentos que la orquesta necesita.", "El juego finaliza una vez superados todos los niveles y completada la orquesta con todos los instrumentos."] 
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