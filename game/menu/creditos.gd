extends Control

var textoCreditos = ["Realizado por Cooperativa de Software Libre gcoop en Godot Engine,", "con colaboración de idelcoop - Instituto de la Cooperación", "y la Universidad Nacional de José C. Paz, en el marco del Programa de Educación en Cooperativismo", "y Economía Social en la Universidad de la Secretaría de Políticas Universitarias.", "Las ilustraciones son de Claudio 'Maléfico' Andaur y la versión 8 bits de 'La Yumba' la hizo Juan Bourbon.", "Las melodías que suenan al finalizar cada nivel las tocó y grabó Mateo Monk.", "Mas info:"]

func _ready():
	var dialog = get_node("/root/global").get_dialog()
	dialog.mostrarTexto(textoCreditos)
	dialog.conectarBoton("_on_jugar_pressed", get_parent())
	add_child(dialog)
