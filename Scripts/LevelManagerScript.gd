extends Node

class_name  LevelManager

static var MainMenu: PackedScene
static var Levels: Array[PackedScene]
static var currentLevel: int = -1
static var infoIsLoaded: bool = false

@export var StartingScene: PackedScene
@export var LevelList: Array[PackedScene]

func _ready() -> void:
	if(!infoIsLoaded):
		MainMenu = StartingScene
		Levels = LevelList
		infoIsLoaded = true
		pass
	get_tree().change_scene_to_packed(MainMenu)
	pass # Replace with function body.
