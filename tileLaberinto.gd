extends Node2D

func _ready():
	var nroNivel = get_node("/root/global").subNivelActual
	var tileMap = load(str("res://TileMap",nroNivel+1,".tscn"))
	call_deferred('add_child', tileMap)