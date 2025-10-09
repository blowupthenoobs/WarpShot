extends Camera2D

class_name MenuScript

@export var CanvasModulator: CanvasModulate
@export var glitchColor: Color
@export var WinScreen: Node2D
@export var DeathCracks: Node2D

static var instance: MenuScript

var stopGame: bool = false


func _ready() -> void:
	instance = self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func winGame() -> void:
	print("You Win!")
	stopGame = true
	WinScreen.visible = true

func _on_menu_button_pressed() -> void:
	LevelManager.currentLevel = -1
	get_tree().change_scene_to_packed(LevelManager.MainMenu)
	pass # Replace with function body.

func _on_next_level_button_pressed() -> void:
	LevelManager.currentLevel += 1
	if(LevelManager.currentLevel < LevelManager.Levels.size()):
		get_tree().change_scene_to_packed(LevelManager.Levels[LevelManager.currentLevel])
	else:
		_on_menu_button_pressed()
	pass # Replace with function body.
