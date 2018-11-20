extends Control

var textoCreditos = ["Realizado por gcoop - Cooperativa de Software Libre en Godot Engine,", "con colaboración de idelcoop - Instituto de la Cooperación", "y la Universidad Nacional de José C. Paz, en el marco del Programa de Educación en Cooperativismo", "y Economía Social en la Universidad de la Secretaría de Políticas Universitarias.", "Las ilustraciones son de Claudio 'Maléfico' Andaur y la versión 8 bits de 'La Yumba' la hizo Juan de Borbón.", "Las melodías que suenan al finalizar cada nivel las tocó y grabó Mateo Monk.", "Mas info:"]
var dialog 

func _ready():
	dialog = get_node("/root/global").get_dialog_volver()
	dialog.mostrarTexto(textoCreditos)
	dialog.conectarBoton("irAlMenu", get_node("/root/global"))
	dialog.conectarTextoCompleto("agregarLinkSitio", self)
	add_child(dialog)
	
func agregarLinkSitio():
	var link = get_node("/root/global").get_link_sitio()
	dialog.add_child(link)
