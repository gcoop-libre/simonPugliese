extends Node

const bandoneon = "bandoneon"
const violin = "violin"
const contrabajo = "contrabajo"

func _ready():
	ubicarItems()

func ubicarItems():
	var instrumentos = [bandoneon, violin, contrabajo, bandoneon, violin, contrabajo, bandoneon, violin, bandoneon, violin]
	var posiciones = get_children()
	var itemScene = load("res://laberinto/items/item.tscn")
	for i in range(posiciones.size()):
		var itemNode = itemScene.instance()
		itemNode.instrumento = instrumentos[i]
		itemNode.get_node(instrumentos[i]).show()
		itemNode.set_pos(posiciones[i].get_pos())
		get_parent().posicionarNodoItem(itemNode)