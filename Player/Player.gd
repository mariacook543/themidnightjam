extends CharacterBody2D

const accel = 400
const max_spd = 150
const friction = 400

var animationplayer = null
var animationtree = null
var animationstate = null
func _ready():
	await get_tree().physics_frame
	animationplayer = $AnimationPlayer
	animationtree = $AnimationTree
	animationstate = animationtree.get("parameters/playback")


func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationtree.set("parameters/Idle/blend_position", input_vector)
		animationtree.set("parameters/Walk/blend_position", input_vector)
		animationstate.travel("Walk")
		velocity = velocity.move_toward(input_vector * max_spd, accel * delta)
		velocity += input_vector * accel * delta	
	else:
		animationstate.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, friction)
	move_and_slide()
