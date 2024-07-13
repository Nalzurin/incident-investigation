extends Control

@export var CluesNum : Label
@export var PlayerState : Label
@onready var survey_end = $SurveyEnd
@onready var survey_start  = $MarginContainer
@onready var end_screen = $EndScreen

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	SoundManager.toggle_mute()
	CluesNum.text = "%02d/%02d" % [GameManager.clues_found , GameManager.clues_total]
	if(GameManager.current_state == "DEAD"):
		PlayerState.text = "Lost contact with employee"
	if(GameManager.current_state == "ESCAPE"):
		PlayerState.text = "Employee returned"
		await start_survey()
	
	

func start_survey():
	await get_tree().create_timer(5).timeout
	end_screen.visible = false
	survey_start.visible = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	survey_end.visible = true
	survey_start.visible = false


func _on_end_shift_pressed():
	get_tree().quit()
