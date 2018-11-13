extends SamplePlayer

export var is_playing = false;

var sonido

func _ready():
	set_process(true)
	
func play_sound(key):
	var timer
	is_playing = true
	if(key == "collision"):
		timer = get_node("timerLargo")
	else:
		timer = get_node("timerCorto")
	timer.start()
	play(key, true)
	yield(timer, "timeout")
	is_playing = false
	sonido = key