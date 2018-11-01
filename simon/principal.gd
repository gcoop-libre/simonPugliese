extends Node2D

var currentPosicion = 0
var patronTocado = []
var textoBienvenida = ["¡Bienvenidos, bienvenidas!", "Osvaldito Pugliese y los músicos quieren armar \nla orquesta y necesitan tu ayuda.", "Te proponemos un desafío ¿Te sumás?", "Prepará las antenas que vas a tener que \nrepetir la melodía"]
var nivel_1 = ['C1', 'D1', 'E2']
var nivel_2 = ['C#1', 'D#1', 'A1']
var nivel_3 = ['A2', 'F#2', 'E2']
var niveles = [nivel_1, nivel_2, nivel_3]
var patron = null
var cantidadNiveles
var dialog

signal nivelGanado

func _ready():
	var nroPatron = get_node("/root/global").subNivelActual
	patron = niveles[nroPatron]
	cantidadNiveles = niveles.size()
	get_node("escenario").add_child(get_node("/root/global").get_orquesta())
	deshabilitarInput(true)
	conectarTeclado()
	get_node("/root/global").play_bg_music()
	if(get_node("/root/global").esPrimerNivel()):
		mostrarPugliese()
		animarTextoBienvenida()
	else:
		get_node("btnEmpezar").show()


func animarTextoBienvenida():
	dialog = get_node("/root/global").get_dialog()
	var polygon = Vector2Array([Vector2(64, 310), Vector2(64, 700), Vector2(610, 700), Vector2(610, 310)])
	dialog.set_polygon(polygon)
	dialog.posicionarTexto(Vector2(92,330))
	dialog.posicionarBoton(Vector2(230,632))
	dialog.mostrarTexto(textoBienvenida)
	dialog.conectarBoton("_on_empezar_pressed", self)
	add_child(dialog)
	
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
				get_node("label/ganaste").show()
				get_node("label/anim").play("mostrar")
				yield(get_node("label/anim"), "finished")
				get_node("label/ganaste").hide()
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
		get_node("label/error").show()
		get_node("label/anim").play("mostrar")
		yield(get_node("label/anim"), "finished")
		get_node("label/error").hide()
		patronTocado = [] 
		continuarPatron()
	
func checkPatronTocado():
	for i in range(patronTocado.size()):
		if str(patronTocado[i]) != str(patron[i]):
			return false
	return true

func jugar():
	mostrarTeclado()
	get_node("teclado/sonidos_ui").play("click")
	currentPosicion = 0
	get_node("btnEmpezar/anim").play("ocultar")
	yield(get_node("btnEmpezar/anim"), "finished")
	get_node("timerCortito").start()
	yield(get_node("timerCortito"), "timeout")
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
	get_node("label/fin").show()
	get_node("label/anim").play("mostrar")
	yield(get_node("label/anim"), "finished")
	get_node("label/fin").hide()
	get_node("teclado/sonidos_ui").play("intro_la_yumba")
	mostrarPugliese()
	get_node("btnEmpezarDeNuevo/anim").play("mostrar")

func _on_btnEmpezarDeNuevo_pressed():
	get_node("btnEmpezarDeNuevo/anim").play("ocultar")
	yield(get_node("btnEmpezarDeNuevo/anim"), "finished")
	get_tree().get_root().get_node("/root/global").empezarJuego()

func animarMusicosOrquesta():
	get_node("escenario/orquesta").animarMusicos()
	
func mostrarPugliese():
	get_node("teclado").quitar_teclas()
	get_node("posicionPugliese").add_child(get_node("/root/global").get_pugliese())
	animarMusicosOrquesta()
	get_node("posicionPugliese/pugliese").play()

func mostrarTeclado():
	get_node("teclado").mostrar_teclas()

func _on_empezar_pressed():
	dialog.ocultar()
	get_node("posicionPugliese/pugliese").queue_free()
	jugar()

func _on_btnEmpezar_pressed():
	jugar()
	
func esJugable():
	return true