extends Node2D

export var tile = ""

func _ready():
	setTile()
	ubicarItems()
	
func ubicarItems():
	var posiciones = tile.get_node("posiciones")
	var itemScene = load("res://laberinto/items/item.tscn")
	for posicionInstrumento in posiciones.get_children():
		var itemNode = itemScene.instance()
		itemNode.configurar(posicionInstrumento)
		tile.get_node("items").add_child(itemNode)

func setTile():
	var nroNivel = get_node("/root/global").subNivelActual
	tile = load(str("res://laberinto/tilemap/nivel_",nroNivel,".tscn")).instance()
	add_child(tile)

func itemsRestantes():
	return tile.get_node("items").get_child_count()