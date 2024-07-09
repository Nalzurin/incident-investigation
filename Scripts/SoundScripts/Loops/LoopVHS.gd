extends AudioStreamPlayer2D
var Sound1 = preload("res://Assets/Sounds/abstract-noise-vhs-static-01.wav")
var Sound2 = preload("res://Assets/Sounds/abstract-noise-vhs-static-02.wav")
func _ready():
	randMusic()
func randMusic():
	match randi_range(1,2):
		1: 
			self.stream = Sound1
		2: 
			self.stream = Sound2
	play()
func _on_finished():
	randMusic()
