extends PanelContainer

func _ready():
	GDSync.lobby_created.connect(lobby_created)
	GDSync.lobby_creation_failed.connect(lobby_creation_failed)

func _on_back_pressed():
	$"../SFX".stream = Globals.sfx_click
	$"../SFX".play()
	visible = false
	%CreateMessage.text = ""

func _on_create_pressed():
	if %Password.text != "":
		if %Password.text.length() < 3:
			$"../SFX".stream = Globals.sfx_error
			$"../SFX".play()
			%CreateMessage.text = "Password is too short! Please try again."
	else:
		var res = TTS.checkProfanity(%LobbyName.text)

		if not res:
			$"../SFX".stream = Globals.sfx_click
			$"../SFX".play()
			GDSync.create_lobby(
				%LobbyName.text,
				%Password.text,
				%Visible.button_pressed,
				%PlayerLimit.value,
				{
					"Gamemode" : "Co-op"
				}
			)
		else:
			$"../SFX".stream = Globals.sfx_error
			$"../SFX".play()
			#%CreateMessage.modulate = Color.INDIAN_RED
			%CreateMessage.text = "Lobby name appears to include Profanity! Please try again."

func lobby_created(lobby_name : String):
	%LobbyJoiner.join_instant(lobby_name, %Password.text)

func lobby_creation_failed(lobby_name : String, error : int):
	#%CreateMessage.modulate = Color.INDIAN_RED
	$"../SFX".stream = Globals.sfx_error
	$"../SFX".play()

	match(error):
		ENUMS.LOBBY_CREATION_ERROR.LOBBY_ALREADY_EXISTS:
			%CreateMessage.text = "A lobby with the name " + lobby_name + " already exists."
		ENUMS.LOBBY_CREATION_ERROR.NAME_TOO_LONG:
			%CreateMessage.text = lobby_name + " is too long."
		ENUMS.LOBBY_CREATION_ERROR.NAME_TOO_SHORT:
			%CreateMessage.text = lobby_name + " is too short."
		ENUMS.LOBBY_CREATION_ERROR.PASSWORD_TOO_LONG:
			%CreateMessage.text = "The password for " + lobby_name + " is too long."
		ENUMS.LOBBY_CREATION_ERROR.TAGS_TOO_LARGE:
			%CreateMessage.text = "The tags have exceeded the 2048 byte limit."
		ENUMS.LOBBY_CREATION_ERROR.DATA_TOO_LARGE:
			%CreateMessage.text = "The data have exceeded the 2048 byte limit."
		ENUMS.LOBBY_CREATION_ERROR.ON_COOLDOWN:
			%CreateMessage.text = "Please wait a few seconds before creating another lobby."
