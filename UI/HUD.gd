extends Control


func _ready():
	update_time()

func update_time():
	$Time.text = "Time:" + str(Global.time)
