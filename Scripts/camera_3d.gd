extends Camera3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _physics_process(delta):
	pass

func _input(event):
	if event is InputEventMouseMotion:
		rotate_object_local(Vector3.UP, event.relative.x * -0.001)
