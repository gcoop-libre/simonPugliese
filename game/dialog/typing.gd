extends SamplePlayer

var tipeando 
var tocando

func _ready():
	tipeando = play("typewriter", false)


func _on_RichTextLabel_textoCompleto():
	stop(tipeando)
