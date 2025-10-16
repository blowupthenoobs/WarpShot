extends Node2D


@export var palerInitialColor: Color
@export var fadeOutWhite: Color
@export var initialColorShiftSpeed: float
@export var timeToStartColorShift: float
@export var fadeOutSpeed: float
@export var expansionSpeed: float
@export var shrinkSpeed: float

var expansionSize: Vector2

var phase: int = 0
var existenceTime: float

var animStarted: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	expansionSize = scale
	scale = Vector2(0, 0)
	animStarted = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	existenceTime += delta
	# quickly grow to a bigger size getting a bit paler, then shrink a bit while turning white and fading out
	if(phase == 0): #growing and slight paling
		if(VectorsAreEqual(scale, expansionSize) && animStarted):
			phase = 1
		if(existenceTime > timeToStartColorShift):
			var shiftAmount: float = delta
			if(existenceTime - delta < timeToStartColorShift):
				shiftAmount = existenceTime - timeToStartColorShift
			modulate = modulate.lerp(palerInitialColor, initialColorShiftSpeed * shiftAmount)
		scale = scale.lerp(expansionSize, expansionSpeed * delta)
		animStarted = true
		pass
	else: #shrink and fade out
		if(ColorsAreEqual(modulate, fadeOutWhite)):
			MenuScript.instance.playerDeath()
		modulate = modulate.lerp(fadeOutWhite, fadeOutSpeed * delta)
		var alpha = modulate.a
		modulate = modulate.lerp(Color.WHITE, fadeOutSpeed * delta * 50)
		modulate.a = alpha
		scale = scale.lerp(Vector2(0, 0), shrinkSpeed * delta)
		pass
	pass


func ColorsAreEqual(colorA: Color, colorB: Color) -> bool:
	if(abs(colorA.r - colorB.r) > .001):
		return false
	if(abs(colorA.g - colorB.g) > .001):
		return false
	if(abs(colorA.b - colorB.b) > .001):
		return false
	if(abs(colorA.a - colorB.a) > .001):
		return false
	
	return true

func VectorsAreEqual(vectorA: Vector2, vectorB: Vector2) -> bool:
	if(abs(vectorA.x - vectorB.x) > .001):
		return false
	if(abs(vectorA.y - vectorB.y) > .001):
		return false
	return true
