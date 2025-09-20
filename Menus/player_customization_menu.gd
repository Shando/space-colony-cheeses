extends Control

func _ready():
	$Music.play(Globals.curMusicPos)
	GDSync.disconnected.connect(disconnected)
	$Help.visible = false
	UniversalSettings.visible = false
	get_tree().get_root().move_child.call_deferred(UniversalSettings, -1)
	get_tree().set_auto_accept_quit(false)
	var pd = GDSync.get_player_data(GDSync.get_client_id(), "Username")
	%Username.text = pd

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		GDSync.quit()

func _on_back_pressed():
	$SFX.stream = Globals.sfx_click
	$SFX.play()
	GDSync.stop_multiplayer()

func disconnected():
	$SFX.stream = Globals.sfx_click
	$SFX.play()
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")

func _on_continue_pressed():
	if %Username.text.length() == 0:
		$SFX.stream = Globals.sfx_click
		$SFX.play()
		return
	elif %Username.text.length() < 3:
		$SFX.stream = Globals.sfx_error
		$SFX.play()
		$PanelContainer/VBoxContainer/ErrorText.text = "Your username is too short! Please try again."
	elif %Username.text.length() > 20:
		$SFX.stream = Globals.sfx_error
		$SFX.play()
		$PanelContainer/VBoxContainer/ErrorText.text = "Your username is too long! Please try again."
	else:
		var res = await TTS.checkProfanity(%Username.text)

		if not res:
			$SFX.stream = Globals.sfx_click
			$SFX.play()
			GDSync.set_player_username(%Username.text)
			GDSync.set_player_data("Color", %Color.color)
			Globals.curMusicPos = $Music.get_playback_position()

			get_tree().change_scene_to_file("res://Menus/lobby_browsing_menu.tscn")
		else:
			$SFX.stream = Globals.sfx_error
			$SFX.play()
			$PanelContainer/VBoxContainer/ErrorText.text = "Your username appears to contain profanity! Please try again."

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
