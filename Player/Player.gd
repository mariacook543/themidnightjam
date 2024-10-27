extends CharacterBody2D

const ACCELERATION = 400
const MAX_SPEED = 150
const FRICTION = 400

@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var animation_state = null  # We'll set this after checking animation_tree

func _ready():
	# Check if nodes exist and are properly connected
	if not animation_player:
		push_error("AnimationPlayer node not found! Check if the node exists and the path is correct.")
		return
		
	if not animation_tree:
		push_error("AnimationTree node not found! Check if the node exists and the path is correct.")
		return
		
	# Only set up animation_state if animation_tree exists
	if animation_tree:
		animation_tree.active = true  # Make sure the AnimationTree is active
		animation_state = animation_tree.get("parameters/playback")
		if not animation_state:
			push_error("Could not get AnimationNodeStateMachinePlayback from AnimationTree!")

func _physics_process(delta):
	# Get input vector
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		# Only update animations if we have a valid animation_tree
		if animation_tree and animation_state:
			animation_tree.set("parameters/Idle/blend_position", input_vector)
			animation_tree.set("parameters/Walk/blend_position", input_vector)
			animation_state.travel("Walk")
		
		# Apply movement
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		# Handle idle state
		if animation_tree and animation_state:
			animation_state.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move_and_slide()
