extends Node2D

func _ready():
	pass

func animarMusicos():
	for musico in get_children():
		musico.play()

func animarNotaMusicos():
	for musico in get_children():
		musico.play("nota-" + musico.get_name())