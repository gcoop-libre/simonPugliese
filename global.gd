extends Node

export var subNivelActual = 0
export var violin = 0
export var bandoneon = 0
export var contrabajo = 0
export var playing_intro = false
export var playing_bg_music = false

var nivelActual = 0
var nivel_1 = {'tipo': 'simon', 'nro': 0}
var nivel_2 = {'tipo': 'laberinto', 'nro': 0}
var nivel_3 = {'tipo': 'simon', 'nro': 1}
var nivel_4 = {'tipo': 'laberinto', 'nro': 1}
var nivel_5 = {'tipo': 'simon', 'nro': 2}
var mapa_niveles = []
var current_scene = null
var orquesta 
var pugliese
var cancion
var dialog
var pausa = load("res://pausa.tscn")

func _ready():
	get_tree().set_auto_accept_quit(false)
	current_scene = get_tree().get_root().get_child(get_tree().get_root().get_child_count() -1 )
	mapa_niveles = [nivel_1, nivel_2, nivel_3, nivel_4, nivel_5]
	orquesta = load("res://orquesta.tscn")
	pugliese = load("res://pugliese.tscn")
	dialog = load("res://dialog.tscn")
	play_intro_song()

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		get_tree().set_pause(true)
		pausarSonido()
		call_deferred("promptSalir")

func promptSalir():
	var confirmationDialog = load("res://ConfirmationDialog.tscn").instance()
	current_scene.add_child(confirmationDialog)
	confirmationDialog.popup()

func resume():
	get_tree().set_pause(false)
	continuarSonido()

func pausarSonido():
	AudioServer.set_stream_global_volume_scale(0)
	AudioServer.set_fx_global_volume_scale(0)

func continuarSonido():
	AudioServer.set_stream_global_volume_scale(1)
	AudioServer.set_fx_global_volume_scale(1)

func esPrimerNivel():
	return (subNivelActual == 0)

func play_intro_song():
	if(!playing_intro):
		get_node("/root/global/musica").stop_all()
		cancion = get_node("/root/global/musica").play('intro_la_yumba')
		playing_intro = true

func play_bg_music():
	get_node("/root/global/musica").stop_all()
	if(mapa_niveles[nivelActual]['tipo'] == 'simon'):
		cancion = get_node("/root/global/musica").play('bg_music')
	else:
		cancion = get_node("/root/global/musica").play('calle')
	playing_intro = false
	playing_bg_music = true

func empezarJuego():
	nivelActual = 0
	subNivelActual = 0
	violin = 0
	bandoneon = 0
	contrabajo = 0
	call_deferred("_deferred_goto_scene", 'res://principal.tscn')

func siguienteNivel():
	var siguienteNivel = nivelActual + 1
	var siguiente = mapa_niveles[siguienteNivel]
	var tipo_siguiente = siguiente['tipo']
	subNivelActual = siguiente['nro']
	var path
	if(tipo_siguiente == 'simon'):
		path = 'res://principal.tscn'
	else:
		path = 'res://laberinto.tscn'
	nivelActual = siguienteNivel
	call_deferred("_deferred_goto_scene", path)

func _deferred_goto_scene(path):
    current_scene = get_tree().get_root().get_child(get_tree().get_root().get_child_count() -1 )
    # Immediately free the current scene,
    # there is no risk here.
    current_scene.free()

    # Load new scene
    var s = ResourceLoader.load(path)

    # Instance the new scene
    current_scene = s.instance()

    # Add it to the active scene, as child of root
    get_tree().get_root().add_child(current_scene)

    # optional, to make it compatible with the SceneTree.change_scene() API
    get_tree().set_current_scene( current_scene )
    current_scene.add_child(get_boton_pausa())

func sumarItem(nombreItem):
	self.set(nombreItem, self.get(nombreItem) + 1)
	
func get_orquesta():
	return orquesta.instance()
	
func get_pugliese():
	return pugliese.instance()

func get_dialog():
	return dialog.instance()

func apretar_ui_button():
	get_node("sonidos_ui").play("click")
	get_node("TimerBoton").start()
	yield(get_node("TimerBoton"), "timeout")

func get_boton_pausa():
	return pausa.instance()