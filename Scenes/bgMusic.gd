extends AudioStreamPlayer

const humanBG = preload("res://Music/bgHuman.ogg")
const devilBG = preload("res://Music/bgDevil.ogg")

func _playMusic(music: AudioStream, volume = 0.0):
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()
	
func playHuman():
	_playMusic(humanBG)
	
func playDevil():
	_playMusic(devilBG)
	
