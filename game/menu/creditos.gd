extends Control

var textoCreditos = ["Realizado por gcoop - Cooperativa de Software Libre, con colaboración de", "Idelcoop Fundación de Educación Cooperativa y la Universidad Nacional de José C. Paz", "en el marco de un proyecto presentado al 'Programa de Cooperativismo y Economía Social", "en la Universidad' de la Secretaría de Políticas Universitarias.", "Las ilustraciones son de Claudio 'Maléfico' Andaur y la versión 8 bits de 'La Yumba' la hizo Juan de Borbón.", "Las melodías que suenan al finalizar cada nivel las tocó y grabó Mateo Monk.", "Mas info:"]
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
