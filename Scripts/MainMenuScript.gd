extends Node

@export var LevelButton: PackedScene
@export var StartingSpot: Vector2
@export var maxButtonPerRow: int
@export var buttonDistance: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var currentColumn: int = 0
	var currentRow: int = 0
	var levelNumber: int = 0
	
	for level in LevelManager.Levels:
		var newButton = LevelButton.instantiate()
		newButton.position = StartingSpot + Vector2(buttonDistance * currentColumn, buttonDistance * currentRow)
		var index: int = currentColumn + (currentRow * maxButtonPerRow)
		newButton.SetUpButton(level, index)
		add_child(newButton)
		
		currentColumn += 1
		if currentColumn >= maxButtonPerRow:
			currentColumn = 0
			currentRow += 1
		pass
	AudioManagerScript.instance.StartMainMenuMusic()
	pass
