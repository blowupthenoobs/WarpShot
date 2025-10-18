extends MenuButton

@export var label: Label
var levelHeld: PackedScene
var levelNumber: int

func SetUpButton(levelContent: PackedScene, handedNumber: int) -> void:
	levelHeld = levelContent
	levelNumber = handedNumber
	label.text = str(levelNumber)
	pass


func _on_pressed() -> void:
	EnemyScript.enemyCount = 0
	LevelManager.currentLevel = levelNumber
	get_tree().change_scene_to_packed(levelHeld)
	pass # Replace with function body.
