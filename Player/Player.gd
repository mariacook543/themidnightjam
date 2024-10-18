extends CharacterBody2D

const accel = 400
const max_spd = 150
const friction = 400


func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * max_spd, accel * delta)
		velocity += input_vector * accel * delta	
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction)
	move_and_collide(velocity * delta)
