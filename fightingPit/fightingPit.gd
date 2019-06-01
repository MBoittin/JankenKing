extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var moves = [0, 0, 0]
var playerLife = 2
var enemyLife = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	#$Bubble.visible = true
	#$Bubble.appendText("I'm the ", "#ffffff")
	#$Bubble.appendText("Referee!", "#C70000")
	pass # Replace with function body.

func resolveGame(victoryCount):
	$Sprites.visible = true
	$Fight.visible = false
	if (victoryCount > 0):
		enemyLife -= 1
		if enemyLife == 0:
			$EndScreen.visible = true
			
		yield(get_tree().create_timer(0.4), "timeout")
		$Sprites/YouWin.visible = true
		$Sprites/AnimationPlayer.play("YouWin")
	elif (victoryCount < 0):
		playerLife -= 1
	yield(get_tree().create_timer(0.7), "timeout")
	

func startHinting():
	$Ennemy.giveHint(moves[0])
	print ("before yield")
	yield($Ennemy, "hint_finished")
	print ("after yield")
	$Ennemy.giveHint(moves[1])
	yield($Ennemy, "hint_finished")
	$Ennemy.giveHint(moves[2])
	yield($Ennemy, "hint_finished")
	$Sprites.visible = false
	$Fight.visible = true
	$Fight.startGame(moves)
	var victoryCount = yield($Fight, "game_end")
	resolveGame(victoryCount)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("ui_accept"):
		for i in range(3):
			moves[i] = randi() % 3
		print(moves)
		startHinting()
	pass
