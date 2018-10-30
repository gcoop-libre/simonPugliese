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

func completarTexto():
	var textoCompleto = array_join(textoDialog, "\n\n")
	set_bbcode(textoCompleto)
	set_visible_characters(textoCompleto.length())
	emit_signal("textoCompleto")
	
func array_join(arr, separator):
    var output = "";
    for s in arr:
        output += str(s) + separator
    output = output.left( output.length() - separator.length() )
    return output

	