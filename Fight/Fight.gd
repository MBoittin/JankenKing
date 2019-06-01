extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var symbol = 0
var playerSymbol = 0
var endOfPlayerTurn = false
var endOfEnnemyTurn = false
var startNextTurn = false
var turnCount = 0
var moves = [0, 0, 0]
var victoryCount = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func startGame(newMoves):
	moves = newMoves
	turnCount = 0
	startNextTurn = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if endOfEnnemyTurn && endOfPlayerTurn:
		endOfEnnemyTurn = false
		endOfPlayerTurn = false
		endTurn()
	if startNextTurn:
		startNextTurn = false
		if turnCount == 3:
			endGame()
		else:
			$PlayerHand.startTurn()
			$Hand.startTurn()
	pass

func endGame():
	if victoryCount > 0:
		print ("You Win")
	elif victoryCount < 0:
		print ("You Loose")
	else:
		print ("The cake is a Tie")

func endTurn():
	var winState = Global.getWinner(playerSymbol, symbol)
	if winState == Global.VictoryState.player1Win:
		victoryCount += 1
	elif winState == Global.VictoryState.player2Win:
		victoryCount -= 1
	yield(get_tree().create_timer(1), "timeout")
	startNextTurn = true

func _on_Hand_animation_finished():
	symbol = moves[turnCount]
	turnCount += 1
	$Hand.selectSprite(Global.symbolsArray[symbol])
	endOfEnnemyTurn = true
	pass # Replace with function body.


func _on_PlayerHand_player_turn_end(selectedAction):
	print ("test")
	playerSymbol = selectedAction
	endOfPlayerTurn = true
	pass # Replace with function body.
