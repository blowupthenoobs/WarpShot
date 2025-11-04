extends Node

class_name  LevelManager

static var MainMenu: PackedScene
static var Levels: Array[PackedScene]
static var Experimentals: Array[PackedScene]
static var currentLevel: int = -1
static var experimental: bool = false
static var infoIsLoaded: bool = false

@export var StartingScene: PackedScene
@export var LevelList: Array[PackedScene]
@export var ExtraLevels: Array[PackedScene]

func _ready() -> void:
	if(!infoIsLoaded):
		MainMenu = StartingScene
		Levels = LevelList
		Experimentals = ExtraLevels
		infoIsLoaded = true
		pass
	get_tree().change_scene_to_packed(MainMenu)
	pass # Replace with function body.

static func getNextLevel() -> PackedScene:
	if(!experimental):
		return Levels[currentLevel]
	else:
		return Experimentals[currentLevel]
