extends Node

var voices = []
var voiceID = 0
var voiceVolume = 50
var dProfanity = {}

# Call to get list of all available voices
# Returns an Array of voice information dictionaries.
#
# Each Dictionary contains three String entries:
#
#	name is voice name.
#	id is voice identifier.
#	language is language code in lang_Variant format.
#		The lang part is a 2 or 3-letter code based on the ISO-639 standard, in lowercase.
#		The Variant part is an engine-dependent string describing country, region or/and dialect.
func getVoices():
	voices = DisplayServer.tts_get_voices()
	return voices

# Call to set both voiceID and LANGUAGE
func setVoice(iIn = 0):
	voiceID = voices[iIn - 1]

# Call to set voiceVolume
func setVolume():
	voiceVolume = UniversalSettings.settings_data.voice_volume * 100

# Call to Speak
func speak(inTxt):
	inTxt = inTxt.replace("[br]", " ")
	inTxt = inTxt.replace("!", ".")
	inTxt = inTxt.replace("?", ".")

	for x in voices:
		if x.name == voiceID.name:
			DisplayServer.tts_speak(inTxt, x.id, voiceVolume, 0.9, 1.0, 0, true)
			break

func is_speaking():
	return DisplayServer.tts_is_speaking()

func stop():
	DisplayServer.tts_stop()

func loadProfanityData():
	var myData_file = FileAccess.open("res://Data/profanity.json", FileAccess.READ)
	var json = JSON.new()
	var _tSett = json.parse(myData_file.get_as_text())
	myData_file.close()

	for prof in json.data:
		dProfanity[prof.word] = true

func checkProfanity(inTxt):
	var wordsInText = inTxt.to_lower().split(" ", false)

	for word in wordsInText:
		if dProfanity.has(word):
			return true

	return false
