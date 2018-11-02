extends Timer

func _ready():
	pass

func _on_RichTextLabel_textoCompleto():
	stop()
	queue_free()

func _on_Timer_timeout():
	set_wait_time(rand_range(0.04,0.1))