extends Area


func _ready():
	pass


func _on_Enemy_body_entered(body):
	if body.name == "Player":
		var _scene = get_tree().change_scene("res://UI/Lose.tscn")

func die():
	queue_free()
