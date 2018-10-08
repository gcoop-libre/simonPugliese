extends Node2D

func _ready():
	var nroNivel = get_node("/root/global").subNivelActual
	var tileMap = load(str("res://TileMap",nroNivel+1,".tscn")).instance()
	add_child(tileMap)