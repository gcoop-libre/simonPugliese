extends Node2D
var timer

func _ready():
	timer = Timer.new()
	get_parent().add_child(timer)

func animarMusicos():
	for musico in get_children():
		musico.set_process(true)

func pararConTimer(tiempo):
	timer.set_wait_time(tiempo)
	timer.start()
	yield(timer, "timeout")
	for musico in get_children():
		musico.set_process(false)