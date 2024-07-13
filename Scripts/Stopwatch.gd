extends Label
@export var TimeLabel : Label
var time_elapsed: float = 0.0
var paused = false
func _toggle_pause():
	paused = !paused
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!paused):
		time_elapsed += delta
		update_time_display()
func update_time_display():
	var hours = int(time_elapsed) / 3600
	var minutes = (int(time_elapsed) % 3600) / 60
	var seconds = int(time_elapsed) % 60
	text = "%02d:%02d:%02d" % [hours, minutes, seconds]
	TimeLabel.text = "AM %02d:%02d" % [hours + 1, minutes]
