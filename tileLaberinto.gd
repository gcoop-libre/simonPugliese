extends Node2D

var tileActivo

func _ready():
	var nroNivel = get_node("/root/global").subNivelActual
	var tiles = load(str("res://tiles_laberinto.tscn")).instance()
	tileActivo = tiles.get_node(str("tilemap_",nroNivel+1))
	tileActivo.show()
	add_child(tiles)
	
func cantidadItems():
	return tileActivo.get_node("items").get_child_count()
