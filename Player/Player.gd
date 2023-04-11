extends KinematicBody

onready var Camera = $Pivot/shake_camera

var to_pickup = null

var gravity = -30
var max_speed = 8
var mouse_sensitivity = 0.002
var mouse_range = 1.2

var velocity = Vector3()

func get_input():
	var input_dir = Vector3()
	if Input.is_action_pressed("forward"):
		input_dir += -Camera.global_transform.basis.z
	if Input.is_action_pressed("back"):
		input_dir += Camera.global_transform.basis.z
	if Input.is_action_pressed("left"):
		input_dir += -Camera.global_transform.basis.x
	if Input.is_action_pressed("right"):
		input_dir += Camera.global_transform.basis.x
	input_dir = input_dir.normalized()
	return input_dir

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		$Pivot.rotate_x(event.relative.y * mouse_sensitivity)
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -mouse_range, mouse_range)

func _physics_process(delta):
	velocity.y += gravity * delta
	var desired_velocity = get_input() * max_speed
	
	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	velocity = move_and_slide(velocity, Vector3.UP, true)

	if Input.is_action_just_pressed("pickup"):
		pickup()
	
	if Input.is_action_just_pressed("throw"):
		if $Pivot.has_node("bomb"):
			throw($Pivot/bomb)

func pickup():
	var bomb = get_node_or_null("Pivot/bomb")
	if bomb != null:
		pass
	elif to_pickup != null:
		bomb = to_pickup.Pickup.instance()
		$Pivot.add_child(bomb)
		to_pickup.queue_free()

func throw(bomb):
	var Bombs = get_node_or_null("/root/Game/Bombs")
	if Bombs != null:
		var temp = bomb.global_transform.origin
		$Pivot.remove_child(bomb)
		Bombs.add_child(bomb)
		bomb.global_transform.origin = temp
		bomb.apply_impulse(temp - Vector3(0,1,1), Vector3(0, 10, -10))
		bomb.find_node("Timer").start()

#func _on_Area_body_entered(body):
	#if body.name == "bomb":
		#to_pickup = body


#func _on_Area_body_exited(body):
	#to_pickup = null

