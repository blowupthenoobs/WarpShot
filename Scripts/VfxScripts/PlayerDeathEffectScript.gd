extends Node2D

@export var EnemyRed: Color
@export var colorShiftSpeed: float
@export var expansionSpeed: float
@export var shrinkSpeed: float

var expansionVectors: Vector2
var phase: int = 0

var animStarted: bool = false
func starteffect(angle: float, spawnPos: Vector2):
	MenuScript.instance.stopGame = true
	rotation = angle
	position = spawnPos
	expansionVectors = scale * 1.2
	animStarted = true
	pass

func _process(delta: float) -> void:
	if(phase == 0 && animStarted):
		if(ColorsAreEqual(modulate, EnemyRed)):
			phase = 1
			pass
		
		modulate = modulate.lerp(EnemyRed, colorShiftSpeed * delta) #I realize I did a stupid here, but the effect looks good, so who cares (I'm not about to recalibrate it)

		scale = scale.lerp(expansionVectors, expansionSpeed * delta)
	elif(phase == 1):
		scale = scale.lerp(Vector2(0, 0), shrinkSpeed * delta)
		
		if(VectorsAreEqual(scale, Vector2(0, 0))):
			MenuScript.instance.playerDeath()
			queue_free()
			pass
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
