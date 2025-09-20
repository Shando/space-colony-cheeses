extends Control

signal account_created(email, username, password)
signal account_creation_failed(email, username, password, response_code)

@onready var email_input : LineEdit = %Email
@onready var username_input : LineEdit = %Username
@onready var password_input : LineEdit = %Password
@onready var password_input_2 : LineEdit = %Password2
@onready var error_text : Label = %ErrorText

@onready var asp = "../Music/"
@onready var aspSFX = "../SFX/"

var busy : bool = false

func create_account() -> void:
	if busy:
		return

	busy = true

	var email : String = email_input.text
	var username : String = username_input.text
	var password : String = password_input.text
	var password2 : String = password_input_2.text

	if username.length() < 3:
		set_error_text(ENUMS.ACCOUNT_CREATION_RESPONSE_CODE.USERNAME_TOO_SHORT)
	elif username.length() > 20:
		set_error_text(ENUMS.ACCOUNT_CREATION_RESPONSE_CODE.USERNAME_TOO_LONG)
	elif password.length() < 3:
		set_error_text(ENUMS.ACCOUNT_CREATION_RESPONSE_CODE.PASSWORD_TOO_SHORT)
	elif password.length() > 20:
		set_error_text(ENUMS.ACCOUNT_CREATION_RESPONSE_CODE.PASSWORD_TOO_LONG)
	elif password == password2:
		var res = TTS.checkProfanity(username)

		if not res:
			var response_code : int = await GDSync.create_account(email, username, password)

			if response_code == ENUMS.ACCOUNT_CREATION_RESPONSE_CODE.SUCCESS:
				aspSFX.stream = Globals.sfx_ok
				aspSFX.play()
				error_text.text = ""
				account_created.emit(email, username, password)
				Globals.curMusicPos = asp.get_playback_position()
				get_tree().change_scene_to_file("res://Menus/login_menu.tscn")
			else:
				set_error_text(response_code)
				account_creation_failed.emit(email, username, password, response_code)
		else:
			set_error_text(ENUMS.ACCOUNT_CREATION_RESPONSE_CODE.PROFANITY_DETECTED)
	else:
		set_error_text(ENUMS.ACCOUNT_CREATION_RESPONSE_CODE.PASSWORDS_DONT_MATCH)

	busy = false

func _on_back_button_pressed() -> void:
	aspSFX.stream = Globals.sfx_click
	aspSFX.play()
	Globals.curMusicPos = asp.get_playback_position()
	get_tree().change_scene_to_file("res://Menus/login_menu.tscn")

func set_error_text(response_code : int) -> void:
	aspSFX.stream = Globals.sfx_error
	aspSFX.play()

	match(response_code):
		ENUMS.ACCOUNT_CREATION_RESPONSE_CODE.NO_RESPONSE_FROM_SERVER:
			error_text.text = "No response from server."
		ENUMS.ACCOUNT_CREATION_RESPONSE_CODE.DATA_CAP_REACHED:
			error_text.text = "Data transfer cap has been reached."
		ENUMS.ACCOUNT_CREATION_RESPONSE_CODE.RATE_LIMIT_EXCEEDED:
			error_text.text = "Rate limit exceeded, please wait and try again."
		ENUMS.ACCOUNT_CREATION_RESPONSE_CODE.NO_DATABASE:
			error_text.text = "API key has no linked database."
		ENUMS.ACCOUNT_CREATION_RESPONSE_CODE.STORAGE_FULL:
			error_text.text = "Database is full."
		ENUMS.ACCOUNT_CREATION_RESPONSE_CODE.INVALID_EMAIL:
			error_text.text = "Invalid email address."
		ENUMS.ACCOUNT_CREATION_RESPONSE_CODE.INVALID_USERNAME:
			error_text.text = "Username contains illegal characters."
		ENUMS.ACCOUNT_CREATION_RESPONSE_CODE.EMAIL_ALREADY_EXISTS:
			error_text.text = "An account with this email address already exists."
		ENUMS.ACCOUNT_CREATION_RESPONSE_CODE.USERNAME_ALREADY_EXISTS:
			error_text.text = "An account with this username address already exists."
		ENUMS.ACCOUNT_CREATION_RESPONSE_CODE.USERNAME_TOO_SHORT:
			error_text.text = "Username is too short."
		ENUMS.ACCOUNT_CREATION_RESPONSE_CODE.USERNAME_TOO_LONG:
			error_text.text = "Username is too long."
		ENUMS.ACCOUNT_CREATION_RESPONSE_CODE.PASSWORD_TOO_SHORT:
			error_text.text = "Password is too short."
		ENUMS.ACCOUNT_CREATION_RESPONSE_CODE.PASSWORD_TOO_LONG:
			error_text.text = "Password is too long."
		ENUMS.ACCOUNT_CREATION_RESPONSE_CODE.PASSWORDS_DONT_MATCH:
			error_text.text = "Passwords don't match."
		ENUMS.ACCOUNT_CREATION_RESPONSE_CODE.PROFANITY_DETECTED:
			error_text.text = "Username appears to include Profanity."
