extends Control

func _ready():
	$Music.play(Globals.curMusicPos)
	GDSync.disconnected.connect(disconnected)
	$Help.visible = false
	UniversalSettings.visible = false
	get_tree().get_root().move_child.call_deferred(UniversalSettings, -1)
	get_tree().set_auto_accept_quit(false)

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		GDSync.quit()

func disconnected():
	$SFX.stream = Globals.sfx_error
	$SFX.play()
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")

func _on_back_pressed():
	$SFX.stream = Globals.sfx_click
	$SFX.play()
	Globals.curMusicPos = $Music.get_playback_position()
	get_tree().change_scene_to_file("res://Menus/player_customization_menu.tscn")

func _on_create_lobby_pressed():
	$SFX.stream = Globals.sfx_click
	$SFX.play()
	%LobbyCreator.visible = true

func _on_join_manual_pressed():
	$SFX.stream = Globals.sfx_click
	$SFX.play()
	%LobbyJoiner.join_manual()

func _on_lobby_browser_join_pressed(lobby_name : String, has_password : bool):
	$SFX.stream = Globals.sfx_click
	$SFX.play()

	if has_password:
		%LobbyJoiner.join_password_protected(lobby_name)
	else:
		%LobbyJoiner.join_instant(lobby_name)

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_F1 and not event.is_echo() and event.is_pressed():
			$SFX.stream = Globals.sfx_click
			$SFX.play()

			if UniversalSettings.visible:
				UniversalSettings.quit_menu()

			if $Help.visible:
				$Help.visible = false
			else:
				$Help.visible = true
		elif event.keycode == KEY_F2 and not event.is_echo() and event.is_pressed():
			$SFX.stream = Globals.sfx_click
			$SFX.play()

			if $Help.visible:
				$Help.visible = false

			if UniversalSettings.visible:
				UniversalSettings.quit_menu()
			else:
				UniversalSettings.show_screen()
