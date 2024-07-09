extends AudioStreamPlayer2D
func _ready():
	self.play()
func _on_finished():
	self.queue_free() # Replace with function body.
