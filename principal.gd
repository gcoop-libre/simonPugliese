extends Node2D

var currentPosicion = 0
var patronTocado = []

var nivel_1 = ['C1', 'D1', 'E2']
var nivel_2 = ['C#1', 'D#1', 'A1']
var nivel_3 = ['A2', 'F#2', 'E2']
var niveles = [nivel_1, nivel_2, nivel_3]
var patron = null
var cantidadNiveles

signal nivelGanado

func _ready():
	var nroPatron = get_node("/root/global").subNivelActual
	patron = niveles[nroPatron]
	cantidadNiveles = niveles.size()
	get_node("escenario").add_child(get_node("/root/global").get_orquesta())
	deshabilitarInput(true)
	conectarTeclado()
	get_node("/root/global").play_bg_music()

func conectarTeclado():
	for octava in get_node("teclado").get_children():
		for boton in octava.get_children():
			boton.connect("apretado", self, "boton_apretado" )

func boton_apretado(quien):
	patronTocado.append( str(quien.get_name()) )
	if ( checkPatronTocado() ):
		if patronTocado.size() == currentPosicion + 1:
			currentPosicion += 1
			 
			if currentPosicion == patron.size():
				get_node("teclado/sonidos_ui").play("aplausos")
				animarMusicosOrquesta()
				get_node("error/panel/Label").set_text("muy bien, diste en la tecla! :)")
				get_node("error/anim").play("mostrar")
				yield( get_node("error/anim"), "finished" )
				if hayMasNiveles():
					get_node("/root/global").siguienteNivel()
					pass
				else:
					ganarJuego()
				return
				
			deshabilitarInput(true)
			get_node("timerRespuesta").start()
			yield( get_node("timerRespuesta"), "timeout" )
			continuarPatron()
	else:
		deshabilitarInput(true)
		get_node("teclado/sonidos_ui").play("error")
		get_node("error/anim").play("mostrar")
		yield( get_node("error/anim"), "finished" )
		patronTocado = [] 
		continuarPatron()
	
func checkPatronTocado():
	for i in range(patronTocado.size()):
		if str(patronTocado[i]) != str(patron[i]):
			return false
	return true

func _on_btnEmpezar_pressed():
	get_node("teclado/sonidos_ui").play("click")
	currentPosicion = 0
	get_node("btnEmpezar/anim").play("ocultar")
	yield(get_node("btnEmpezar/anim"), "finished")
	get_node("timerCortito").start()
	yield( get_node("timerCortito"), "timeout" )
	continuarPatron()

func continuarPatron():
	patronTocado = []
	for i in range(0,currentPosicion+1):
		var nombreBoton = patron[i]
		var nombreOctava = "octava" + str(nombreBoton[-1])
		var boton = get_node("teclado/"+nombreOctava+"/" + nombreBoton )
		boton.apretar()
		yield( boton, "finApretado")
	deshabilitarInput(false)
	
func deshabilitarInput(booleano):
	for octava in get_node("teclado").get_children():
		for boton in octava.get_children():
			get_node("teclado/"+octava.get_name()+"/"+boton.get_name()+"/boton-lb").set_disabled(booleano)

func hayMasNiveles():
	return cantidadNiveles - 1 > get_node("/root/global").subNivelActual
	
func ganarJuego():
	# agregar sonido de aplausos
	get_node("error/panel/Label").set_text("Osvaldito y los músicos están listos para tocar!")
	get_node("error/anim").play("mostrar")
	get_node("teclado/sonidos_ui").play("intro_la_yumba")
	get_node("teclado").quitar_teclas()
	get_node("escenario").add_child(get_node("/root/global").get_pugliese())
	animarMusicosOrquesta()
	get_node("escenario/pugliese").play()
	get_node("btnEmpezarDeNuevo/anim").play("mostrar")

func _on_btnEmpezarDeNuevo_pressed():
	get_node("btnEmpezarDeNuevo/anim").play("ocultar")
	yield(get_node("btnEmpezarDeNuevo/anim"), "finished")
	get_tree().get_root().get_node("/root/global").empezarJuego()

func animarMusicosOrquesta():
	get_node("escenario/orquesta").animarMusicos()