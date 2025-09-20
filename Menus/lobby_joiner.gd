extends PanelContainer

func _ready():
	GDSync.lobby_joined.connect(lobby_joined)
	GDSync.lobby_join_failed.connect(lobby_join_failed)

func lobby_joined(_lobby_name : String):
	get_tree().change_scene_to_file("res://Menus/lobby.tscn")

func lobby_join_failed(lobby_name : String, error : int):
	#%JoinMessage.modulate = Color.INDIAN_RED
	$"../SFX".stream = Globals.sfx_error
	$"../SFX".play()

	match(error):
		ENUMS.LOBBY_JOIN_ERROR.LOBBY_DOES_NOT_EXIST:
			%JoinMessage.text = "The lobby "+lobby_name+" does not exist."
		ENUMS.LOBBY_JOIN_ERROR.LOBBY_IS_CLOSED:
			%JoinMessage.text = "The lobby "+lobby_name+" is closed."
		ENUMS.LOBBY_JOIN_ERROR.LOBBY_IS_FULL:
			%JoinMessage.text = "The lobby "+lobby_name+" is full."
		ENUMS.LOBBY_JOIN_ERROR.INCORRECT_PASSWORD:
			%JoinMessage.text = "The password for lobby "+lobby_name+" was incorrect."
		ENUMS.LOBBY_JOIN_ERROR.DUPLICATE_USERNAME:
			%JoinMessage.text = "The lobby "+lobby_name+" already contains your username."

func join_manual():
	visible = true
	%JoinNameBox.visible = true
	%JoinPasswordBox.visible = true

func join_password_protected(lobby_name : String):
	visible = true
	%JoinName.text = lobby_name
	%JoinNameBox.visible = false

func join_instant(lobby_name : String, password : String = ""):
	visible = true
	%JoinName.text = lobby_name
	%JoinPassword.text = password
	%JoinNameBox.visible = false
	%JoinPasswordBox.visible = false
	%Join.visible = false
	_on_join_pressed()

func reset_join_menu():
	%JoinName.text = ""
	%JoinPassword.text = ""
	%JoinMessage.text = ""
	%Join.visible = true

func _on_back_pressed():
	$"../SFX".stream = Globals.sfx_click
	$"../SFX".play()
	reset_join_menu()
	visible = false

func _on_join_pressed():
	$"../SFX".stream = Globals.sfx_click
	$"../SFX".play()
	GDSync.join_lobby(%JoinName.text, %JoinPassword.text)
