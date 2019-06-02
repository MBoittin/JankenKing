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

signal game_end

# Called when the node enters the scene tree for the first time.
func _ready():
	$Hand/Sprite.flip_h = true
	pass # Replace with function body.

func startGame(newMoves):
	$ResetSymbols.play("ResetSymbols")
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
			print("StartNext")
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
	emit_signal("game_end", victoryCount)

func endTurn():
	var winState = Global.getWinner(playerSymbol, symbol)
	print ("Winner is", winState)
	if winState == Global.VictoryState.player1Win:
		print("Number 1")
		victoryCount += 1
		yield($Hand/AnimationPlayer, "animation_finished")
		$Hand/AnimationPlayer.play("Destruction")
		yield($Hand/AnimationPlayer, "animation_finished")
	elif winState == Global.VictoryState.player2Win:
		victoryCount -= 1
		yield($PlayerHand/Hand/AnimationPlayer, "animation_finished")
		$PlayerHand/Hand/AnimationPlayer.play("Destruction")
		yield($PlayerHand/Hand/AnimationPlayer, "animation_finished")
	if turnCount != 3:
		$ResetSymbols.play("ResetSymbols")
	yield(get_tree().create_timer(1), "timeout")
	startNextTurn = true

func _on_Hand_animation_finished():
	symbol = moves[turnCount]
	turnCount += 1
	$Hand.selectSprite(Global.symbolsArray[symbol])
	endOfEnnemyTurn = true
	pass # Replace with function body.


func _on_PlayerHand_player_turn_end(selectedAction):
	endOfPlayerTurn = true
	if playerSymbol == Global.Symbols.rock:
		$Ciseaux/Hide.play("Hide")
		$Ciseaux/AnimationPlayer.stop()
		$Papier/Hide.play("Hide")
		$Papier/AnimationPlayer.stop()
		$Pierre/Selection.play("Selection")
		yield($Pierre/Selection, "animation_finished")
		$Pierre/AnimationPlayer2.play("Selected")
	if playerSymbol == Global.Symbols.scissors:
		$Pierre/AnimationPlayer.stop()
		$Papier/AnimationPlayer.stop()
		$Papier/Hide.play("Hide")
		$Pierre/Hide.play("Hide")
		$Ciseaux/Selection.play("Selection")
		yield($Ciseaux/Selection, "animation_finished")
		$Ciseaux/AnimationPlayer2.play("Selected")
	if playerSymbol == Global.Symbols.paper:
		$Ciseaux/AnimationPlayer.stop()
		$Pierre/AnimationPlayer.stop()
		$Ciseaux/Hide.play("Hide")
		$Pierre/Hide.play("Hide")
		$Papier/Selection.play("Selection")
		yield($Papier/Selection, "animation_finished")
		$Papier/AnimationPlayer2.play("Selected")
	pass # Replace with function body.


func _on_PlayerHand_selected_symbol(selectedSymbol):
	if !endOfEnnemyTurn:
		playerSymbol = selectedSymbol
	$Ciseaux/AnimationPlayer2.stop()
	$Pierre/AnimationPlayer2.stop()
	$Papier/AnimationPlayer2.stop()

	if selectedSymbol == Global.Symbols.rock:
		$Pierre/Selection.play("Selection")
		yield($Pierre/Selection, "animation_finished")
		$Pierre/AnimationPlayer2.play("Selected")
	if selectedSymbol == Global.Symbols.scissors:
		$Ciseaux/Selection.play("Selection")
		yield($Ciseaux/Selection, "animation_finished")
		$Ciseaux/AnimationPlayer2.play("Selected")
	if selectedSymbol == Global.Symbols.paper:
		$Papier/Selection.play("Selection")
		yield($Papier/Selection, "animation_finished")
		$Papier/AnimationPlayer2.play("Selected")
	pass # Replace with function body.
