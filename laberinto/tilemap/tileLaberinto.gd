extends Node2D

func _ready():
	var tiles = load(str("res://laberinto/tilemap/tiles_laberinto.tscn")).instance()
	add_child(tiles)