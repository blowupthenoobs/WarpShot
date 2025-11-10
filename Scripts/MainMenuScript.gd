extends Node

@export var LevelButton: PackedScene
@export var StartingSpot: Vector2
@export var maxButtonPerRow: int
@export var buttonDistance: float

var buttons: Array[Button] = []
var currentHighlightedLevel: int = 0
static var usingController: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(!LevelManager.experimental):
		makeLevels()
	else:
		makeLevels(LevelManager.Experimentals)
	AudioManagerScript.instance.StartMainMenuMusic()
	pass

func makeLevels(levelList: Array[PackedScene] = LevelManager.Levels) -> void:
	var currentColumn: int = 0
	var currentRow: int = 0
	
	for level in levelList:
		var newButton = LevelButton.instantiate()
		newButton.position = StartingSpot + Vector2(buttonDistance * currentColumn, buttonDistance * currentRow)
		var index: int = currentColumn + (currentRow * maxButtonPerRow)
		newButton.SetUpButton(level, index)
		add_child(newButton)
		buttons.append(newButton)
		
		currentColumn += 1
		if currentColumn >= maxButtonPerRow:
			currentColumn = 0
			currentRow += 1
		pass
	pass

func moveLevelSelection(amount: int) -> void:
	if(amount + currentHighlightedLevel > buttons.size() - 1):
		while(amount + currentHighlightedLevel > buttons.size() - 1):
			amount -= buttons.size()
			pass
		pass
	if(amount + currentHighlightedLevel < 0):
		while(amount + currentHighlightedLevel < 0):
			amount += buttons.size()
			pass
		pass
	
	buttons[currentHighlightedLevel].unselectLevel()
	currentHighlightedLevel += amount
	buttons[currentHighlightedLevel].selectLevel()
	pass

func _toggle_experimental() -> void:
	LevelManager.experimental = !LevelManager.experimental
	while(buttons.size() > 0):
		buttons[0].queue_free()
		buttons.remove_at(0)
	
	if(!LevelManager.experimental):
		makeLevels()
	else:
		makeLevels(LevelManager.Experimentals)
	pass # Replace with function body.


func _input(event: InputEvent) -> void:
	if(event is InputEventMouseMotion):
		usingController = false
	if(event is InputEventJoypadButton || event is InputEventJoypadMotion):
		usingController = true
		
	if(event.is_action_pressed("JoyUp")):
		moveLevelSelection(maxButtonPerRow)
		pass
	if(event.is_action_pressed("JoyRight")):
		moveLevelSelection(1)
		pass
	if(event.is_action_pressed("JoyDown")):
		moveLevelSelection(-maxButtonPerRow)
		pass
	if(event.is_action_pressed("JoyLeft")):
		moveLevelSelection(-1)
		pass
	
	
	if(event.is_action_pressed("JoyConfirm")):
		buttons[currentHighlightedLevel]._on_pressed()
		pass
	if(event.is_action_pressed("JoyOptions")):
		_toggle_experimental()
		pass
	pass
