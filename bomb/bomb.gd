extends RigidBody

func _ready():
	$Timer.start()

func _on_bomb_body_entered(body):
	if body.name == "Enemy":
		$Flash.cause_trauma()
		var exit = get_node_or_null("root/Maze/Exit")
		if exit != null:
			exit.unlock()
			queue_free()
	$Enemy.die()

func explode():
	$bomb.queue_free()
	$Explosion.play()
	

func _on_Timer_timeout():
	$bomb.hide()
	$Explosion.show()
	$Explosion.play()


func _on_Explosion_animation_finished():
	queue_free()
