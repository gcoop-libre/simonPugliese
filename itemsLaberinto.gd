extends Node2D

var currentItems

func _ready():
	setearPosiciones()
	ubicarItems()

func ubicarItems():
	var itemScene = load("res://item.tscn")
	for instrumento in currentItems:
		for pos in instrumento.posiciones:
			var itemNode = itemScene.instance()
			itemNode.instrumento = instrumento.nombre
			itemNode.get_node(instrumento.nombre).show()
			itemNode.set_pos(pos)
			add_child(itemNode)

func setearPosiciones():
	var pos1 = Vector2(162,386)
	var pos2 = Vector2(258,482)
	var pos3 = Vector2(738,386)
	var pos4 = Vector2(738,674)
	var pos5 = Vector2(930,194)
	var pos6 = Vector2(1202,580)
	var pos7 = Vector2(738,290)
	var pos8 = Vector2(930,290)
	var pos9 = Vector2(642,482)
	var pos10 = Vector2(738,674)
	var pos11 = Vector2(530,674)
	var pos12 = Vector2(66,98)
	var nivel_0 = [{'nombre': 'bandoneon', 'posiciones': [pos1, pos2]}, {'nombre': 'contrabajo', 'posiciones': [pos3]}, {'nombre': 'violin', 'posiciones': [pos4, pos5, pos6]}]
	var nivel_1 = [{'nombre': 'bandoneon', 'posiciones': [pos7, pos8, pos9]}, {'nombre': 'contrabajo', 'posiciones': [pos10]}, {'nombre': 'violin', 'posiciones': [pos11, pos12]}]
	var items = [nivel_0, nivel_1]
	var nroNivel = get_node("/root/global").subNivelActual
	currentItems = items[nroNivel] 
	