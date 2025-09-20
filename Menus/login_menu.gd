extends Control

func _ready():
	$Music.play(Globals.curMusicPos)
	$Help.visible = false
	get_tree().get_root().move_child.call_deferred(UniversalSettings, -1)
	get_tree().set_auto_accept_quit(false)

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		GDSync.quit()

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
