extends Node


onready var message = $Message
onready var button_correct = $Correct
onready var button_greater = $Greater
onready var button_lesser = $Lesser


var guess
var min_guessed = 0
var max_guessed = 1000
var ended = false

func _ready():
	guess = (min_guessed + max_guessed) / 2
	print("-----------------------------")
	print("-----------------------------")
	print("-----------------------------")
	print("---숫자 맞추기에 참여 하신 걸 환영해요---")
	print("0 부터 1000 사이 숫자를 하나 생각하세요. 제가 맞춰 볼께요!")
	print("당신이 생각하는 숫자가 " + str(guess) + "입니까?")
	message.text = "Is " + str(guess) + " your number?"
 
func _process(delta):
	if Input.is_action_just_pressed("up"):
		#print("Up key Pressed.")
		_on_Greater_pressed()
	elif Input.is_action_just_pressed("down"):
		#print("down key Pressed.")
		_on_Lesser_pressed()
	elif Input.is_action_just_pressed("space"):
		_on_Correct_pressed()
	
func _try_guess(type):
	if type == "up":
		min_guessed = guess
	else:
		max_guessed = guess
		
	guess = (min_guessed + max_guessed) / 2
	print("당신이 생각하는 숫자가 " + str(guess) + "입니까?")
	message.text = "Is " + str(guess) + " your number?"
	
	
func _end_game():
	ended = true
	print("아항~ 알겠어요 당신이 생각하는 숫자는 " + str(guess) + "군요!")
	message.text = "Your Number is " + str(guess) + " !"
	button_correct.text = "Restart?"
	
	
	
func _restart_game():
	get_tree().reload_current_scene()
	
	
func _on_Greater_pressed():
	_try_guess("up")
	
func _on_Lesser_pressed():
	_try_guess("down")
	
func _on_Correct_pressed():
	if ended:
		_restart_game()
	else:
		_end_game()
