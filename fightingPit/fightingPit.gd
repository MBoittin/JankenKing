extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var moves = [0, 0, 0]
var playerLife = 0
var enemyLife = 0
var LifeIcon = preload("res://Life.tscn")

signal endHinting
signal valid

enum States {
	pause,
	speaking
	}

var state = States.pause
var activeBubble = null
var enemyBubble = null

func addLifeToPlayer():
	var index = $UI/PlayerLife.get_child_count()

	$UI/PlayerLife.add_child(LifeIcon.instance())
	$UI/PlayerLife.get_child(index).create()
	playerLife += 1
	pass

func addLifeToEnemy():
	var index = $UI/EnemyLife.get_child_count()

	$UI/EnemyLife.add_child(LifeIcon.instance())
	$UI/EnemyLife.get_child(index).setFlip()
	$UI/EnemyLife.get_child(index).set("show_behind_parent", true)
	$UI/EnemyLife.get_child(0).set("show_behind_parent", false)
	$UI/EnemyLife.get_child(0).create()
	enemyLife += 1
	pass

func removeEnemyLife():
	enemyLife -= 1
	$UI/EnemyLife.get_child(0).destroy()
	yield(get_tree().create_timer(0.8), "timeout")
	$UI/EnemyLife.remove_child($UI/EnemyLife.get_child(0))
	if ($UI/EnemyLife.get_child_count() > 0):
		$UI/EnemyLife.get_child(0).set("show_behind_parent", false)

func removePlayerLife():
	playerLife -= 1
	var index = $UI/PlayerLife.get_child_count()
	$UI/PlayerLife.get_child(index - 1).destroy()
	yield(get_tree().create_timer(0.8), "timeout")
	$UI/PlayerLife.remove_child($UI/PlayerLife.get_child(index - 1))

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.endGame = false
	yield(get_tree().create_timer(0.7), "timeout")
	$JanKenKing.playing = true
	activeBubble = $RefereeBubble
	state = States.speaking
	yield(self, "valid")
	$MenuScreen.queue_free()
	self.remove_child($MenuScreen)
	enemyBubble = $HirotoBubble
	yield(get_tree().create_timer(1), "timeout")
	addLifeToPlayer()
	addLifeToEnemy()
	yield(get_tree().create_timer(1), "timeout")
	addLifeToPlayer()
	addLifeToEnemy()
	yield(get_tree().create_timer(1), "timeout")
	addLifeToEnemy()
	yield(get_tree().create_timer(1), "timeout")
	randomize()
	launchTutorial()
	#$Bubble.visible = true
	#$Bubble.appendText("I'm the ", "#ffffff")
	#$Bubble.appendText("Referee!", "#C70000")
	pass # Replace with function body.

func launchTutorial():
	activeBubble = $RefereeBubble
	activeBubble.appendText("   HELLO EVERYONE !\n    AND WELCOME TO\n", "#f2f2f2")
	activeBubble.appendText("    JANKEN KIIING !!! \n", "#f4cd2a")
	activeBubble.speak()
	state = States.speaking
	yield(self, "valid")
	activeBubble.appendText("     WAIT... THIS IS\n   YOUR FIRST TIME ?\n\t\t", "#f2f2f2")
	activeBubble.appendText("REALLY ???", "#b266b2")
	activeBubble.speak()
	state = States.speaking
	yield(self, "valid")
	activeBubble.appendText(" \tTHIS IS PRETTY\n\tSIMPLE ! ALL \n\tYOU HAVE TO DO IS\n\tTO LISTEN !", "#f2f2f2")
	activeBubble.speak()
	state = States.speaking
	yield(self, "valid")
	activeBubble = $HirotoBubble
	activeBubble.appendText("\n I WILL ", "#f2f2f2")
	activeBubble.appendText(" CRUSH ", "#782020")
	activeBubble.appendText(" YOU !", "#f2f2f2")
	activeBubble.speak()
	state = States.speaking
	yield(self, "valid")
	activeBubble = $RefereeBubble
	activeBubble.appendText(" \t\t... SEE ?\n\t HE ALREADY GAVE\n\t\t YOU A ", "#f2f2f2")
	activeBubble.appendText(" CLUE !", "#0000b2")
	activeBubble.speak()
	state = States.speaking
	yield(self, "valid")
	activeBubble = $RefereeBubble
	activeBubble.appendText(" \t\tREADY NOW ?\n\t\tOK LEEEET'S \n\t\t\tGOOOO !\n", "#f2f2f2")
	activeBubble.speak()
	state = States.speaking
	yield(self, "valid")
	initTurn([0, 0, 0])

func initTurn(setMoves):
	$Sprites/Presenter/AnimationPlayer.stop()
	$Sprites/Presenter/JANKENGO.play("JANKENGO")
	activeBubble = $JAN
	activeBubble.appendText("[center][b]JAN[/b][/center]", "#f2f2f2")
	activeBubble.speak()
	yield(get_tree().create_timer(0.6), "timeout")
	activeBubble.stopSpeaking()
	activeBubble = $KEN
	activeBubble.appendText("[center][b]KEN[/b][/center]", "#f2f2f2")
	activeBubble.speak()
	yield(get_tree().create_timer(0.6), "timeout")
	activeBubble.stopSpeaking()
	activeBubble = $GO
	activeBubble.appendText("[center][b]GO[/b][/center]", "#f2f2f2")
	activeBubble.speak()
	yield(get_tree().create_timer(0.6), "timeout")
	activeBubble.stopSpeaking()
	moves = setMoves
	$Sprites/Presenter/AnimationPlayer.play("PresenterIdle")
	startTurn()

func resolveGame(victoryCount):
	$Sprites.visible = true
	$Fight.visible = false
	if (victoryCount > 0):
		removeEnemyLife()
		yield(get_tree().create_timer(0.8), "timeout")
		if enemyLife == 0:
			$EndScreen.setEndScreen(Global.lukasWin, Global.HirotoLoose, true)
			$EndScreen.visible = true
		yield(get_tree().create_timer(0.4), "timeout")
		#$Sprites/YouWin.visible = true
		#$Sprites/AnimationPlayer.play("YouWin")
	elif (victoryCount < 0):
		removePlayerLife()
		yield(get_tree().create_timer(0.8), "timeout")
		if playerLife == 0:
			$EndScreen.setEndScreen(Global.lukasLoose, Global.HirotoWin, false)
			$EndScreen.visible = true
	if victoryCount != 0:
		$Sprites/Crowd/Sprite/AnimationPlayer.play("Hooray")
		$Sprites/Presenter/AnimationPlayer.stop()
		if (victoryCount < 0):
			$Sprites/Presenter.flip_h = true
			$Sprites/Presenter/Winning.play("EnemyWin")	
		else:
			$Sprites/Presenter/Winning.play("win")
		yield($Sprites/Crowd/Sprite/AnimationPlayer, "animation_finished")

		$Sprites/Presenter/Winning.stop()
		$Sprites/Presenter/AnimationPlayer.play("PresenterIdle")
		$Sprites/Presenter.flip_h = false
		
	victoryCount = 0
	yield(get_tree().create_timer(1), "timeout")
	if !Global.endGame:
		enemyAI()

func enemyAI():
	for i in range(3):
		moves[i] = randi() % 3
	startHinting(moves)
	yield(self, "endHinting")
	yield(get_tree().create_timer(0.5), "timeout")
	initTurn(moves)

func startTurn():
	$Sprites.visible = false
	$Fight.visible = true
	$Fight.startGame(moves)
	var victoryCount = yield($Fight, "game_end")
	resolveGame(victoryCount)

func throwHint(move):
	if move == Global.Symbols.rock:
		activeBubble = $HirotoBubble
		activeBubble.appendText("\n \tI AM SOLID AS A\n", "#f2f2f2")
		activeBubble.appendText("\t\t\tROCK !", "#782020")
		activeBubble.speak()
		state = States.speaking
	elif move == Global.Symbols.scissors:
		activeBubble = $HirotoBubble
		activeBubble.appendText("\n \t\tI WILL", "#f2f2f2")
		activeBubble.appendText(" SLICE ", "#0000cc")
		activeBubble.appendText("\tYOUR HEAD OFF !", "#f2f2f2")
		activeBubble.speak()
		state = States.speaking
	else:
		activeBubble = $HirotoBubble
		activeBubble.appendText("\n \tTHIS WILL BE YOUR\n", "#f2f2f2")
		activeBubble.appendText("\t\t\t\tFALL ", "#329932")
		activeBubble.speak()
		state = States.speaking
	pass

func startHinting(selectedMoves):
	#$Ennemy.giveHint(moves[0])
	throwHint(moves[0])
	yield(get_tree().create_timer(1.5), "timeout")
	activeBubble.stopSpeaking()
	state = States.pause
	yield(activeBubble, "animation_finished")
	yield(get_tree().create_timer(0.7), "timeout")
	if (moves[0] != moves[1]):
		throwHint(moves[1])
		yield(get_tree().create_timer(1.5), "timeout")
		activeBubble.stopSpeaking()
		state = States.pause
		yield(activeBubble, "animation_finished")
		yield(get_tree().create_timer(0.7), "timeout")
	if (moves[2] != moves[1] && moves[2] != moves[0]):
		throwHint(moves[2])
		yield(get_tree().create_timer(1.5), "timeout")
		activeBubble.stopSpeaking()
		state = States.pause
		yield(activeBubble, "animation_finished")
		yield(get_tree().create_timer(0.7), "timeout")
	emit_signal("endHinting")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("ui_accept") && state != States.pause:
		if state == States.speaking:
			activeBubble.stopSpeaking()
			state = States.pause
			yield(activeBubble, "animation_finished")
			emit_signal("valid")
		#for i in range(3):
		#	moves[i] = randi() % 3
		#print(moves)
		#startHinting()
	pass
