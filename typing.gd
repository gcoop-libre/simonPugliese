extends SamplePlayer

var tipeando 
var tocando

func _ready():
	self.tipeando = play("typewriter-1", false)

func _on_RichTextLabel_textoCompleto():
	stop(self.tipeando)