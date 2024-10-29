extends Node

var mouse_sensitivity = 0.06 # Using variable not set value allows for easier tweaks and debugging




func _ready():
	self.rotation_degrees.y = 0 # Centers camera on start
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) # Locks mouse in game.
	
	
func _unhandled_input(event): # Allows for overriding if needed e.g. jumpscare
	if event is InputEventMouseMotion: # Checks if mouse is moved
		self.rotation_degrees.y -= event.relative.x * mouse_sensitivity # Rotates camera
		self.rotation_degrees.y = clamp(self.rotation_degrees.y, -90, 90) # Stops camera turning too far

