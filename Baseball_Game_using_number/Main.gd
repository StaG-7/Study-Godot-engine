extends Node

var correctArray = []
var answerArray = [0, 0, 0]
var leftCount = 10
var uiIndex = 3

onready var firstNumber = $FirstNumberList
onready var secondNumber = $SecondNumberList
onready var thirdNumber = $ThirdNumberList
onready var strikeCount = $StrikeCountLabel
onready var ballCount = $BallCountLabel
onready var guessButton = $GuessButton

const FIRST_NUMBERLIST = 3
const SECOND_NUMBERLIST = 4
const THIRD_NUMBERLIST = 5

func _ready():
	var wIndex = 0
	randomize()
	while wIndex < 3:
		#숫자 3개를 랜덤하게 생성하여 각각 다른 숫자를 배열에 저장
		var randomNumber = randi()%10
		if correctArray.size() == 0:
			#배열의 크기가 0일 경우 첫번째 숫자 저장
			correctArray.append(randomNumber)
			wIndex += 1
		else:
			if !correctArray.has(randomNumber):
				correctArray.append(randomNumber)
				wIndex += 1
				

	
	#배열 결과 출력
	print("------------- correctArray ---------------")
	for fIndex in range(0,correctArray.size()):
		print(str(fIndex) +" - "+ str(correctArray[fIndex]))
	
	#3개 숫자 리스트 0~9로 초기화
	for value in range(0, 10):
		firstNumber.add_item(str(value))
		secondNumber.add_item(str(value))
		thirdNumber.add_item(str(value))
		
	firstNumber.grab_focus()



func _process(delta):
	#키 입력으로 인한 처리
	if Input.is_action_just_pressed("ui_accept"):
		if !guessButton.disabled:
			_on_GuessButton_pressed()
	#아이템 리스트 포커스를 키보드로 변경
	elif Input.is_action_just_pressed("ui_left"):
		if uiIndex <= FIRST_NUMBERLIST:
			uiIndex = THIRD_NUMBERLIST
		else:
			uiIndex -=1
		_focus_UI()
	elif Input.is_action_just_pressed("ui_right"):
		if uiIndex >= THIRD_NUMBERLIST:
			uiIndex = FIRST_NUMBERLIST
		else:
			uiIndex +=1
		_focus_UI()

#첫번째 숫자리스트의 숫자가 선택 또는 변경 되었을 때
func _on_FirstNumberList_item_selected(index):
	print("First > "+str(index))
	answerArray[0] = index

#두번째 숫자리스트의 숫자가 선택 또는 변경 되었을 때
func _on_SecondNumberList_item_selected(index):
	print("Second > "+str(index))
	answerArray[1] = index

#세번째 숫자리스트의 숫자가 선택 또는 변경 되었을 때
func _on_ThirdNumberList_item_selected(index):
	print("Third > "+str(index))
	answerArray[2] = index

#예측버튼이 눌러졌을 때
func _on_GuessButton_pressed():
	print("------------- answerArray ---------------")
	for fIndex in range(0,answerArray.size()):
		print(str(fIndex) +" - "+ str(answerArray[fIndex]))
	leftCount -= 1
	guessButton.text ="예측 (남은횟수:"+str(leftCount)+")"
	if leftCount == 0:
		_endGame("예측횟수 초과!")
	_tryGuess()
	

func _tryGuess():
	var strike = 0
	var ball = 0
	for cindex in range(0,correctArray.size()):
		for aindex in range(0,answerArray.size()):
			if correctArray[cindex] == answerArray[aindex]:
				if cindex == aindex:
					strike += 1
				else:
					ball += 1
	_resultPrint(strike, ball)
	if strike == 3:
		_endGame("예측이 맞았습니다!")

func _resultPrint(var strike=0, var ball=0):
	strikeCount.text = "S:"+str(strike)
	ballCount.text = "B:"+str(ball)

func _endGame(var message):
	guessButton.text = message
	guessButton.disabled = true

func _on_RestartButton_pressed():
	get_tree().reload_current_scene()

#아이템 리스트 포커스를 키보드로 변경
func _focus_UI():
	match uiIndex:
		FIRST_NUMBERLIST:
			firstNumber.grab_focus()
		SECOND_NUMBERLIST:
			secondNumber.grab_focus()
		THIRD_NUMBERLIST:
			thirdNumber.grab_focus()
		

