extends CanvasLayer

@onready var lblTimer = get_node("%lblTImer")
var time =0
func change_time(argtime =0):
	time = argtime
	var get_m = int(time/60.0)
	var get_s = int(time%60)
	if get_m < 10 :
		get_m = str(0,get_m)
	if get_s < 10:
		get_s = str(0,get_s)
	lblTimer.text = str(get_m,":",get_s)
