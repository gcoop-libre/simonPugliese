extends Node2D

signal apretado
signal finApretado

func _ready():
	pass


func _on_botonlb_apretado():
	emit_signal("apretado", self)
	pass # replace with function body

func apretar():
	get_node("boton-lb").apretar()
	get_node("Timer").start()

func _on_Timer_timeout():
	get_node("boton-lb").desapretar()
	emit_signal("finApretado")
