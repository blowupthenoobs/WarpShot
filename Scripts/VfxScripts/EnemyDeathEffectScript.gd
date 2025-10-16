extends Node2D

@export var white: Color
@export var colorShiftSpeed: float
@export var timeToStartColorShift: float
@export var expansionSize: float
@export var expansionSpeed: float

var expansionVectors: Vector2
var existenceTime: float

func starteffect(angle: float, spawnPos: Vector2):
	rotation = angle
	position = spawnPos
	expansionVectors = scale * expansionSize
	pass

func _process(delta: float) -> void:
	existenceTime += delta
	if(existenceTime > timeToStartColorShift):
		var shiftAmount: float = colorShiftSpeed
		if(existenceTime - delta < timeToStartColorShift):
			shiftAmount = existenceTime - timeToStartColorShift
		modulate = modulate.lerp(white, shiftAmount * delta) #I realize I did a stupid here, but the effect looks good, so who cares (I'm not about to recalibrate it)
		pass
	scale = scale.lerp(expansionVectors, expansionSpeed * delta)
	
	if(ColorsAreEqual(modulate, white)):
		queue_free()
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
