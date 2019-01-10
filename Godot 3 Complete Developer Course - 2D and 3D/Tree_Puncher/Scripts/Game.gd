extends Node

export (PackedScene) var trunk_scene

onready var firstTrunkPosition = $FirstTrunkPosition
onready var grave = $Grave
onready var timeLeft = $TimeLeft
onready var player = $Player
onready var timer = $Timer


var lastSpawnPosition
var lastHasAxe = false
var lastAxeRight = false
var dead = false


var trunks = []

func _ready():
	lastSpawnPosition = firstTrunkPosition.position
	_spawnFirstTrunks()


func _process(delta):
	if dead:
		return
	timeLeft.value -= delta
	if timeLeft.value <= 0:
		die()


func _spawnFirstTrunks():
	for counter in range(5):
		var newTrunk = trunk_scene.instance()
		add_child(newTrunk)
		newTrunk.position = lastSpawnPosition
		lastSpawnPosition.y -= newTrunk.spriteHeight
		newTrunk._initializeTrunk(false, false)
		trunks.append(newTrunk)
	

func _add_trunk(axe, axeRight):
	var newTrunk = trunk_scene.instance()
	add_child(newTrunk)
	newTrunk.position = lastSpawnPosition
	newTrunk._initializeTrunk(axe, axeRight)
	trunks.append(newTrunk)


func _punchTree(fromRight):
	
	if !lastHasAxe:
		if rand_range(0,100) > 50:
			lastAxeRight = rand_range(0,100) > 50
			lastHasAxe = true
			
		else:
			lastHasAxe = false
			
	else:
		if rand_range(0,100) > 50:
			lastHasAxe = true
			
		else:
			lastHasAxe = false
			
	_add_trunk(lastHasAxe, lastAxeRight)
	
	trunks[0]._remove(fromRight)
	trunks.pop_front()
	for trunk in trunks:
		trunk.position.y += trunk.spriteHeight
		
	timeLeft.value += 0.25
	if timeLeft.value > timeLeft.max_value:
		timeLeft.value = timeLeft.max_value
	
	
	
func die():
	grave.position.x = player.position.x
	player.queue_free()
	timer.start()
	grave.visible = true
	dead = true
	

func _on_Timer_timeout():
	get_tree().reload_current_scene()
