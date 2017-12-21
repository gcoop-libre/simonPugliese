extends Node2D

var patron = [1, 3, 5, 3, 1]
var currentPosicion = 0
var patronTocado = []

func _ready():
	for boton in get_node("botones").get_children():
		boton.connect("apretado", self, "boton_apretado" )

func boton_apretado(quien):
	patronTocado.append( int(quien.get_name()) )
	if ( checkPatronTocado() ):
		if patronTocado.size() == currentPosicion + 1:
			currentPosicion += 1
			
			if currentPosicion == patron.size():
				get_node("error/panel/Label").set_text("ganaste!")
				get_node("error/anim").play("mostrar")
				yield( get_node("error/anim"), "finished" )
				return
			
			get_node("timerRespuesta").start()
			yield( get_node("timerRespuesta"), "timeout" )
			continuarPatron()
	else:
		get_node("error/anim").play("mostrar")
		yield( get_node("error/anim"), "finished" )
		patronTocado = []
		continuarPatron()

func checkPatronTocado():
	for i in range(patronTocado.size()):
		if patronTocado[i] != patron[i]:
			return false

	return true

func _on_btnEmpezar_pressed():
	currentPosicion = 0
	continuarPatron()

func continuarPatron():
	patronTocado = []
	for i in range(0,currentPosicion+1):
		var nombreBoton = patron[i]
		var boton = get_node("botones/" + str(nombreBoton) )
		boton.apretar()
		yield( boton, "finApretado")