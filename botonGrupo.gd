extends Node2D

signal apretado
signal finApretado

func _ready():
	pass
	
func _on_botonlb_apretado():
	emit_signal("apretado", self)

func apretar():
	get_node("boton-lb").apretar()
	get_node("boton-lb").mostrar_como_apretado()
	get_node("Timer").start()

func _on_Timer_timeout():
	get_node("boton-lb").mostrar_normal()
	emit_signal("finApretado")
	
func tocar(nota):
	get_parent().get_node("escenario/orquesta").animarMusicos()
	get_parent().get_node("escenario/orquesta").pararConTimer(0.25)
	get_node("sonidos").play(nota)

func quitar_teclas():
	get_node("fondo_piano").queue_free()
	get_node("octava1").queue_free()
	get_node("octava2").queue_free()