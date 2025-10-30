extends Node2D

class_name AudioManagerScript
@export var MusicPlayer: AudioStreamPlayer2D

@export var MainMenuMusic: AudioStream
@export var startingMenuDb: float
@export var endingMenuDb: float
@export var menuMusicDbShiftSpeed: float

@export var GameMusic: AudioStream
@export var startingGameDb: float
@export var endingGameDb: float
@export var gameMusicDbShiftSpeed: float

static var instance: AudioManagerScript
var songPlaying: String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	instance = self
	pass # Replace with function body.


func _process(delta: float) -> void:
	if(songPlaying == "mainMenu"):
		MusicPlayer.volume_db = lerp(MusicPlayer.volume_db, endingMenuDb, menuMusicDbShiftSpeed * delta)
		pass
	pass

func StartMainMenuMusic() -> void:
	MusicPlayer.stream = MainMenuMusic
	MusicPlayer.volume_db = startingMenuDb
	songPlaying = "mainMenu"
	MusicPlayer.playing = true
	TurnOffSfxEffects()
	pass

func StartGameMusic() -> void:
	if(songPlaying != "game"):
		MusicPlayer.stream = GameMusic
		MusicPlayer.volume_db = startingGameDb
		songPlaying = "game"
		MusicPlayer.playing = true
	TurnOffSfxEffects()
	pass

static func FailedTeleportEffect() -> void:
	AudioServer.set_bus_volume_db(1, -12)
	AudioServer.set_bus_effect_enabled(1, 0, true)
	AudioServer.set_bus_effect_enabled(1, 1, true)
	AudioServer.set_bus_effect_enabled(1, 2, true)
	pass

static func TurnOffSfxEffects() -> void:
	AudioServer.set_bus_volume_db(1, 0)
	for i in range(AudioServer.get_bus_effect_count(1)):
		AudioServer.set_bus_effect_enabled(1, i, false)
		pass
	pass
