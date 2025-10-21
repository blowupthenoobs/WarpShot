extends AudioStreamPlayer2D

var soundStarted: bool = false

func PlaySound(sound: AudioStream, vol: float, variation: float = 0) -> void:
	stream = sound
	volume_db = vol
	pitch_scale = variation
	playing = true
	soundStarted = true
	pass

func _process(delta: float) -> void:
	if(soundStarted && !playing):
		queue_free()
	pass
