extends Control

var iDiff = 4
var oldHostID = -1
var chkOld = -1

func _init():
	GDSync.disconnected.connect(disconnected)
	GDSync.host_changed.connect(host_changed)
	GDSync.client_joined.connect(client_joined)
	GDSync.client_left.connect(client_left)
	GDSync.expose_func(switch_scene)

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		GDSync.quit()

func disconnected():
	$SFX.stream = Globals.sfx_error
	$SFX.play()
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")

func _ready():
	$Music.play(Globals.curMusicPos)
	$Help.visible = false
	iDiff = GDSync.get_lobby_player_limit() - GDSync.get_lobby_player_count()

	if GDSync.is_host():
		%Start.disabled = true
		%Start.visible = true
	else:
		%Start.visible = false

	%Waiting.visible = true
	UniversalSettings.visible = false
	get_tree().get_root().move_child.call_deferred(UniversalSettings, -1)
	get_tree().set_auto_accept_quit(false)

func host_changed(is_host : bool, _new_host_id : int):
	if oldHostID != _new_host_id:
		oldHostID = _new_host_id

		if GDSync.is_host():
			%Start.disabled = true
			%Start.visible = true
		else:
			%Start.visible = false

		checkPlayers()

func client_joined(client_id : int):
	$SFX.stream = Globals.sfx_ok
	$SFX.play()
	var label : Label = Label.new()
	label.name = str(client_id)
	%PlayerList.add_child(label)
	label.text = GDSync.get_player_data(client_id, "Username", "Unkown")
	label.modulate = GDSync.get_player_data(client_id, "Color", Color.WHITE)
	%PlayerCount.text = str(GDSync.get_lobby_player_count()) + "/" + str(GDSync.get_lobby_player_limit())
	checkPlayers()

func client_left(client_id : int):
	$SFX.stream = Globals.sfx_error
	$SFX.play()

	if %PlayerList.has_node(str(client_id)):
		%PlayerList.get_node(str(client_id)).queue_free()

	%PlayerCount.text = str(GDSync.get_lobby_player_count()) + "/" + str(GDSync.get_lobby_player_limit())

	if GDSync.is_host():
		%Start.disabled = true

	checkPlayers()

func checkPlayers():
	iDiff = GDSync.get_lobby_player_limit() - GDSync.get_lobby_player_count()

	if chkOld != iDiff:
		chkOld = iDiff

		if iDiff == 0:
			if GDSync.is_host():
				%Start.disabled = false
				%Waiting.set_text("All players joined! You can now start the game.")
			else:
				%Waiting.set_text("Waiting for host to start the game.")
		else:
			%Waiting.set_text("Waiting for " + str(iDiff) + " more player(s) to join.")

func _on_start_pressed():
	$SFX.stream = Globals.sfx_click
	$SFX.play()
	GDSync.close_lobby()
	GDSync.call_func(switch_scene)
	Globals.curMusicPos = 0.0
	switch_scene()

func switch_scene():
	get_tree().change_scene_to_file("res://Main.tscn")

func _on_leave_pressed():
	$SFX.stream = Globals.sfx_click
	$SFX.play()
	GDSync.leave_lobby()
	Globals.curMusicPos = $AudioStreamPlayer.get_playback_position()
	get_tree().change_scene_to_file("res://Menus/lobby_browsing_menu.tscn")

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
