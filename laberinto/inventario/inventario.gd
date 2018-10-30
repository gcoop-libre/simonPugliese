extends HBoxContainer

func _ready():
	get_node("violin/Background/Number").set_text(str(global.violin))
	get_node("contrabajo/Background/Number").set_text(str(global.contrabajo))
	get_node("bandoneon/Background/Number").set_text(str(global.bandoneon))
	
func agregarItem(nombreItem):
	global.sumarItem(nombreItem)
	var cantidadActual = get_node(nombreItem + "/Background/Number").get_text()
	var cantidadNueva = int(cantidadActual) + 1
	get_node(nombreItem + "/Background/Number").set_text(str(cantidadNueva))
	get_node("itemSounds").play(nombreItem)