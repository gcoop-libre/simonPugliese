extends Node2D

export var tileActivo = ""

func _ready():
	setTileActivo()
	ubicarItems()

func ubicarItems():
	var posiciones = tileActivo.get_node("posiciones")
	var itemScene = load("res://laberinto/items/item.tscn")
	for posicionInstrumento in posiciones.get_children():
		var itemNode = itemScene.instance()
		itemNode.configurar(posicionInstrumento)
		tileActivo.get_node("items").add_child(itemNode)

func setTileActivo():
	var nroNivel = get_node("/root/global").subNivelActual
	tileActivo = get_node(str("tilemap_", nroNivel))
	tileActivo.show()

func itemsRestantes():
	return tileActivo.get_node("items").get_child_count()