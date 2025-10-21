extends Camera2D

class_name MenuScript

enum ShaderMode {GrayScale = 2, Desaturate = 3, ChromeAber = 5}

@export var ShaderController: ColorRect
@export var LevelName: Label
@export var glitchColor: Color
@export var invisible: Color
@export var WinScreen: Node2D
@export var Flash: Node2D
@export var DeathSlider: Node2D
@export var SlidePosition: Node2D
@export var slideSpeed: float
@export var flashSpeed: float
@export var levelTextFadeSpeed: float
@export var maxChromeAbber: float
@export var chromeAbberSpeed: float
@export var soundEffectPlayer: PackedScene

static var instance: MenuScript
static var level: String
var stopGame: bool = false
var rotateAnyway: bool = false
var playerKilled: bool = false
var currentShaders: int = 1

var chromeAbberStrength: float = 0

func _ready() -> void:
	instance = self
	var root = get_tree().current_scene
	
	if(level != root.name):
		stopGame = true
		rotateAnyway = true
		LevelName.text = root.name
		LevelName.visible = true
		level = root.name
	else:
		LevelName.visible = false
	
	UpdateShaders()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	slideDeathEffect(delta)
	fadeOutLevelName(delta)
	playDeathChromAbber(delta)
	pass

func winGame() -> void:
	stopGame = true
	WinScreen.visible = true

func _on_menu_button_pressed() -> void:
	level = ""
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


func PlaySound(sound: AudioStream, vol: float, variation: float = 0) -> void:
	var instance = soundEffectPlayer.instantiate()
	add_sibling(instance)
	instance.PlaySound(sound, vol, variation)
	pass


func playerDeath() -> void:
	EnemyScript.enemyCount = 0
	playerKilled = true
	pass

func badTeleport() -> void:
	stopGame = true
	TurnOnEffect(ShaderMode.ChromeAber)
	pass

func slideDeathEffect(delta: float) -> void:
	if(playerKilled):
		if(VectorsAreEqual(DeathSlider.position, SlidePosition.position)):
			get_tree().reload_current_scene()
			TurnOffShaders()
		DeathSlider.position = DeathSlider.position.lerp(SlidePosition.position, slideSpeed * delta)
		Flash.modulate = Flash.modulate.lerp(Color.WHITE, flashSpeed * delta)
		if(Flash.modulate.a < .01 && !VectorsAreEqual(DeathSlider.position, SlidePosition.position)):
			TurnOnEffect(ShaderMode.Desaturate)
		#else:
			#TurnOffShaders()
		pass
	pass

func fadeOutLevelName(delta: float) -> void:
	if(LevelName.visible):
		LevelName.modulate = LevelName.modulate.lerp(invisible, levelTextFadeSpeed * delta)
		
		if(LevelName.modulate.a < .3):
			LevelName.visible = false
			stopGame = false
			rotateAnyway = false
			pass
	pass

func playDeathChromAbber(delta: float) -> void:
	if(currentShaders % ShaderMode.ChromeAber == 0):
		chromeAbberStrength += chromeAbberSpeed * delta
		if(chromeAbberStrength >= maxChromeAbber):
			chromeAbberStrength = maxChromeAbber
			playerDeath()
		pass
	else:
		chromeAbberStrength = 0
	
	ShaderController.get_material().set_shader_parameter("chromeAbberStrength", chromeAbberStrength)
	pass

func TurnOffShaders() -> void:
	ShaderController.get_material().set_shader_parameter("effectsToUse", 1)
	pass

func TurnOnEffect(shader: ShaderMode) -> void:
	if((currentShaders % shader) != 0):
		currentShaders *= shader
		UpdateShaders()
	pass

func TurnOffEffect(shader: ShaderMode) -> void:
	if((currentShaders % shader) == 0):
		currentShaders /= shader
		UpdateShaders()
	pass

func UpdateShaders() -> void:
	ShaderController.get_material().set_shader_parameter("effectsToUse", currentShaders)
	pass

func VectorsAreEqual(vectorA: Vector2, vectorB: Vector2) -> bool:
	if(abs(vectorA.x - vectorB.x) > .001):
		return false
	if(abs(vectorA.y - vectorB.y) > .001):
		return false
	return true

func resetGame() -> void:
	pass
