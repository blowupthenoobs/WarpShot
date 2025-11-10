extends MenuButton

@export var label: Label
@export var highlight: Sprite2D
var levelHeld: PackedScene
var levelNumber: int

func SetUpButton(levelContent: PackedScene, handedNumber: int) -> void:
	levelHeld = levelContent
	levelNumber = handedNumber
	label.text = str(levelNumber)
	pass

func selectLevel() -> void:
	highlight.visible = true
	pass

func unselectLevel() -> void:
	highlight.visible = false
	pass

func _on_pressed() -> void:
	EnemyScript.enemyCount = 0
	LevelManager.currentLevel = levelNumber
	get_tree().change_scene_to_packed(levelHeld)
	pass # Replace with function body.
