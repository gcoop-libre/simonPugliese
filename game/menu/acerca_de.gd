extends Control

var textoAcercaDe = ["Simón - Pugliese es un juego educativo para probar el ingenio, los reflejos y la memoria.","Está pensado para niños y niñas de entre 6 y 10 años y se juega de forma individual.","El objetivo es conformar la orquesta de Osvaldo Pugliese y sus músicos. Para ello hay que pasar una serie de niveles en los cuales deberán repetir melodías en un teclado virtual y resolver laberintos. ","En cada jugada se mostrará una melodía nueva que se tendrá que repetir siempre desde el principio y en el mismo orden formando una cadena de sonidos, para ello hay que tocar la tecla adecuada.","A continuación se deberá atravesar un laberinto para conseguir los instrumentos que la orquesta necesita. ","El juego finaliza una vez superados todos los niveles y completada la orquesta con todos los instrumentos."]

func _ready():
	var dialog = get_node("/root/global").get_dialog_volver()
	dialog.mostrarTexto(textoAcercaDe)
	dialog.conectarBoton("irAlMenu", get_node("/root/global"))
	add_child(dialog)

