extends Control

func _ready():
	GDSync.connected.connect(connected)
	GDSync.connection_failed.connect(connection_failed)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$Help.visible = false
	get_tree().get_root().move_child.call_deferred(UniversalSettings, -1)
	get_tree().set_auto_accept_quit(false)
	%Connect.disabled = false
	await TTS.loadProfanityData()

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		_on_quit_pressed()

func _on_connect_pressed():
	%Connect.disabled = true
	$SFX.stream = Globals.sfx_click
	$SFX.play()
	GDSync.start_multiplayer()
	Globals.curMusicPos = $AudioStreamPlayer.get_playback_position()

func _on_quit_pressed():
	$SFX.stream = Globals.sfx_click
	$SFX.play()
	GDSync.quit()

func connected():
	%Connect.disabled = true
	var iLogin = await GDSync.login_from_session()

	# TODO: Remove this - Currently set to 0 so doesn't try to login (for testing)
	iLogin = 0

	match(iLogin):
		ENUMS.LOGIN_RESPONSE_CODE.SUCCESS:
			get_tree().change_scene_to_file("res://Menus/player_customization_menu.tscn")
		ENUMS.LOGIN_RESPONSE_CODE.DATA_CAP_REACHED, ENUMS.LOGIN_RESPONSE_CODE.RATE_LIMIT_EXCEEDED, \
			ENUMS.LOGIN_RESPONSE_CODE.NO_DATABASE, ENUMS.LOGIN_RESPONSE_CODE.NO_RESPONSE_FROM_SERVER:
			$SFX.stream = Globals.sfx_error
			$SFX.play()
			%Message.text = "Sorry, there appears to be a problem with the server at the moment. Please try again later."
			await get_tree().create_timer(3.0).timeout
			GDSync.quit()
		ENUMS.LOGIN_RESPONSE_CODE.EMAIL_OR_PASSWORD_INCORRECT, ENUMS.LOGIN_RESPONSE_CODE.NOT_VERIFIED:
			$SFX.stream = Globals.sfx_error
			$SFX.play()
			%Message.text = "Sorry, there appears to be a problem with your session. Please login."
			await get_tree().create_timer(3.0).timeout
			get_tree().change_scene_to_file("res://Menus/login_menu.tscn")
		ENUMS.LOGIN_RESPONSE_CODE.EXPIRED_SESSION:
			$SFX.stream = Globals.sfx_error
			$SFX.play()
			%Message.text = "Sorry, your session has expired. Please login."
			await get_tree().create_timer(3.0).timeout
			get_tree().change_scene_to_file("res://Menus/login_menu.tscn")
		ENUMS.LOGIN_RESPONSE_CODE.BANNED:
			$SFX.stream = Globals.sfx_error
			$SFX.play()
			%Message.text = "Sorry, you are currently serving a ban. Please try again after your ban has been lifted."
			await get_tree().create_timer(3.0).timeout
			GDSync.quit()

func connection_failed(error : int):
	%Connect.disabled = false
	%Message.modulate = Color.INDIAN_RED

	match(error):
		ENUMS.CONNECTION_FAILED.INVALID_PUBLIC_KEY:
			$SFX.stream = Globals.sfx_error
			$SFX.play()
			%Message.text = "The public or private key you entered were invalid."
		ENUMS.CONNECTION_FAILED.TIMEOUT:
			$SFX.stream = Globals.sfx_error
			$SFX.play()
			%Message.text = "Unable to connect, please check your internet connection."

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_F1 and not event.is_echo() and event.is_pressed():
			if UniversalSettings.visible:
				UniversalSettings.quit_menu()

			if $Help.visible:
				$Help.visible = false
			else:
				$Help.visible = true
		elif event.keycode == KEY_F2 and not event.is_echo() and event.is_pressed():
			if $Help.visible:
				$Help.visible = false

			if UniversalSettings.visible:
				UniversalSettings.quit_menu()
			else:
				UniversalSettings.show_screen()
