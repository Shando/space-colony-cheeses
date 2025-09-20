extends Control

@onready var global = get_tree().get_root().get_node("Spatial")
@onready var dlgConf = $Dialog
@onready var tmrTimer = $Timer
@onready var hoverPopup = $VBoxContainer/Main/Label/HBoxContainer/PanelContainer2
@onready var hoverText = $VBoxContainer/Main/Label/HBoxContainer/PanelContainer2/Messages/txtMessages
@onready var btnCon1 = $VBoxContainer/Main/Modules/PanelContainer2/VBoxContainer/HBoxContainer4/PanelContainer/btnModule1
@onready var btnCon2 = $VBoxContainer/Main/Modules/PanelContainer2/VBoxContainer/HBoxContainer4/PanelContainer2/btnModule2
@onready var btnCon3 = $VBoxContainer/Main/Modules/PanelContainer2/VBoxContainer/HBoxContainer7/PanelContainer/btnModule3
@onready var btnCon4 = $VBoxContainer/Main/Modules/PanelContainer2/VBoxContainer/HBoxContainer7/PanelContainer2/btnModule4
@onready var btnCon5 = $VBoxContainer/Main/Modules/PanelContainer2/VBoxContainer/HBoxContainer6/PanelContainer/btnModule5
@onready var btnCon6 = $VBoxContainer/Main/Modules/PanelContainer2/VBoxContainer/HBoxContainer6/PanelContainer2/btnModule6
@onready var btnCon7 = $VBoxContainer/Main/Modules/PanelContainer2/VBoxContainer/HBoxContainer5/PanelContainer/btnModule7
@onready var btnCon8 = $VBoxContainer/Main/Modules/PanelContainer2/VBoxContainer/HBoxContainer5/PanelContainer2/btnModule8
@onready var btnLeft = $VBoxContainer/Main/Modules/PanelContainer2/VBoxContainer/MarginContainer/HBoxContainer8/btnModuleLeft
@onready var btnPage = $VBoxContainer/Main/Modules/PanelContainer2/VBoxContainer/MarginContainer/HBoxContainer8/btnModulePage
@onready var btnRight = $VBoxContainer/Main/Modules/PanelContainer2/VBoxContainer/MarginContainer/HBoxContainer8/btnModuleRight
@onready var lblP1 = $VBoxContainer/Scores/PanelContainer2/PanelContainer/HBoxContainer/lblP1
@onready var lblP2 = $VBoxContainer/Scores/PanelContainer2/PanelContainer/HBoxContainer/lblP2
@onready var lblP3 = $VBoxContainer/Scores/PanelContainer2/PanelContainer/HBoxContainer/lblP3
@onready var lblP4 = $VBoxContainer/Scores/PanelContainer2/PanelContainer/HBoxContainer/lblP4
@onready var lblScoreP1 = $VBoxContainer/Scores/PanelContainer2/PanelContainer/HBoxContainer/lblScoreP1
@onready var lblScoreP2 = $VBoxContainer/Scores/PanelContainer2/PanelContainer/HBoxContainer/lblScoreP2
@onready var lblScoreP3 = $VBoxContainer/Scores/PanelContainer2/PanelContainer/HBoxContainer/lblScoreP3
@onready var lblScoreP4 = $VBoxContainer/Scores/PanelContainer2/PanelContainer/HBoxContainer/lblScoreP4
@onready var lblRounds = $VBoxContainer/Scores/PanelContainer2/PanelContainer/HBoxContainer/lblRoundsRem
@onready var btnC21 = $VBoxContainer/Main/HBoxContainer7/TabContainer/VBoxContainer/HBoxContainer/VBoxContainer1/C21
@onready var btnC22 = $VBoxContainer/Main/HBoxContainer7/TabContainer/VBoxContainer/HBoxContainer/VBoxContainer2/C22
@onready var btnC23 = $VBoxContainer/Main/HBoxContainer7/TabContainer/VBoxContainer/HBoxContainer/VBoxContainer3/C23
@onready var btnC24 = $VBoxContainer/Main/HBoxContainer7/TabContainer/VBoxContainer/HBoxContainer/VBoxContainer1/C24
@onready var btnC25 = $VBoxContainer/Main/HBoxContainer7/TabContainer/VBoxContainer/HBoxContainer/VBoxContainer2/C25
@onready var btnC26 = $VBoxContainer/Main/HBoxContainer7/TabContainer/VBoxContainer/HBoxContainer/VBoxContainer3/C26
@onready var btnC27 = $VBoxContainer/Main/HBoxContainer7/TabContainer/VBoxContainer/HBoxContainer/VBoxContainer1/C27
@onready var btnC28 = $VBoxContainer/Main/HBoxContainer7/TabContainer/VBoxContainer/HBoxContainer/VBoxContainer2/C28
@onready var btnC29 = $VBoxContainer/Main/HBoxContainer7/TabContainer/VBoxContainer/HBoxContainer/VBoxContainer3/C29
@onready var btnC210 = $VBoxContainer/Main/HBoxContainer7/TabContainer/VBoxContainer/HBoxContainer/VBoxContainer1/C210
@onready var btnC211 = $VBoxContainer/Main/HBoxContainer7/TabContainer/VBoxContainer/HBoxContainer/VBoxContainer3/C211
@onready var btnC2Yes = $VBoxContainer/Main/HBoxContainer7/TabContainer/VBoxContainer/HBoxContainer2/C2Yes
@onready var btnC2No = $VBoxContainer/Main/HBoxContainer7/TabContainer/VBoxContainer/HBoxContainer2/C2No
@onready var btnC2Done = $VBoxContainer/Main/HBoxContainer7/TabContainer/VBoxContainer/HBoxContainer2/C2Done
@onready var btnLbl3 = $VBoxContainer/Main/HBoxContainer7/TabContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Label3
@onready var tabCont = $VBoxContainer/Main/HBoxContainer7/TabContainer
@onready var tabCol1 = $VBoxContainer/Main/HBoxContainer7/TabContainer/VBoxContainer/HBoxContainer/VBoxContainer1
@onready var tabCol2 = $VBoxContainer/Main/HBoxContainer7/TabContainer/VBoxContainer/HBoxContainer/VBoxContainer2
@onready var tabCol3 = $VBoxContainer/Main/HBoxContainer7/TabContainer/VBoxContainer/HBoxContainer/VBoxContainer3
@onready var btnYNDone = $VBoxContainer/Main/HBoxContainer7/TabContainer/VBoxContainer/HBoxContainer2
@onready var txtMessage = $VBoxContainer/Main/HBoxContainer7/PanelContainer/Messages/txtMessages

var tCButtons = []
var mod = null
var sTxt = ""
var RE1 = false
var RE2 = false
var sfx

func _ready():
	get_tree().set_auto_accept_quit(false)
	GDSync.expose_func(updateBank)
	GDSync.expose_func(updatePortal)
	GDSync.expose_func(updateCatalog)
	GDSync.expose_func(updateConstruction)
	GDSync.expose_func(updatePastureDome)
	GDSync.expose_func(updateCheeseLab)
	GDSync.expose_func(updateSausageLab)
	GDSync.expose_func(updateLawOffice)
	sfx = get_node("/root/Spatial/Sfx")
	disableBtnCon(true, 0)
	set_process_input(true)
	setUpCButtons()
	tabCol1.visible = false
	tabCol2.visible = false
	tabCol3.visible = false
	tabCont.visible = false
	btnYNDone.visible = false

func setUpCButtons():
	tCButtons.append(btnC21)
	tCButtons.append(btnC22)
	tCButtons.append(btnC23)
	tCButtons.append(btnC24)
	tCButtons.append(btnC25)
	tCButtons.append(btnC26)
	tCButtons.append(btnC27)
	tCButtons.append(btnC28)
	tCButtons.append(btnC29)
	tCButtons.append(btnC210)
	tCButtons.append(btnC211)
	tCButtons.append(btnC2Yes)
	tCButtons.append(btnC2No)
	tCButtons.append(btnC2Done)

#	string	String to be displayed
#	table	btnC2 Table (optional)
#	number	0 = TEMPORARY MESSAGE,
#			1 = OK (C2Yes),
#			2 = YES (C2Yes) and NO (C2No),
#			3 = NO BUTTONS,
#			4 = OK (C2Yes) and RESET (C2No),
#			5 = OK (C2Yes), DONE (C2Done) and RESET (C2No),
#			6 = DONE (C2Done),
#			7 = DONE (C2Done) and RESET (C2No),
#	string	String to be spoken (if different to display) (optional)
func updateGUI(sIn = "", tIn = [], iYN = 1, sIn2 = ""):
	var parent = hoverPopup.get_parent()
	var current_index = hoverPopup.get_index()

	if current_index != 0:
		parent.move_child(hoverPopup, 0)

	hoverPopup.visible = false

	if not tmrTimer.is_stopped():
		tmrTimer.stop()

	for x in tCButtons:
		x.visible = false
		x.disabled = true

	btnLbl3.visible = false
	tabCol1.visible = false
	tabCol2.visible = false
	tabCol3.visible = false
	tabCont.visible = true
	btnYNDone.visible = false

	match iYN:
		0:
			tmrTimer.set_one_shot(true)
			tmrTimer.start(10)
			tabCont.visible = false
		1:
			btnC2Done.visible = false
			btnC2Done.disabled = true
			btnC2No.visible = false
			btnC2No.disabled = true
			btnC2Yes.visible = true
			btnC2Yes.disabled = false
			btnC2Yes.set_text("OK")
			btnYNDone.visible = true
		2:
			btnC2Done.visible = false
			btnC2Done.disabled = true
			btnC2No.visible = true
			btnC2No.disabled = false
			btnC2No.set_text("NO")
			btnC2Yes.visible = true
			btnC2Yes.disabled = false
			btnC2Yes.set_text("YES")
			btnYNDone.visible = true
		3:
			tabCont.visible = false
		4:
			btnC2Done.visible = false
			btnC2Done.disabled = true
			btnC2No.visible = true
			btnC2No.disabled = false
			btnC2No.set_text("RESET")
			btnC2Yes.visible = true
			btnC2Yes.disabled = false
			btnC2Yes.set_text("OK")
			btnYNDone.visible = true
		5:
			btnC2Done.visible = true
			btnC2Done.disabled = false
			btnC2No.visible = true
			btnC2No.disabled = false
			btnC2No.set_text("RESET")
			btnC2Yes.visible = true
			btnC2Yes.disabled = false
			btnC2Yes.set_text("OK")
			btnYNDone.visible = true
		6:
			btnC2Done.visible = true
			btnC2Done.disabled = false
			btnC2No.visible = false
			btnC2No.disabled = true
			btnC2Yes.visible = false
			btnC2Yes.disabled = true
			btnYNDone.visible = true
		7:
			btnC2Done.visible = true
			btnC2Done.disabled = false
			btnC2No.visible = true
			btnC2No.disabled = false
			btnC2No.set_text("RESET")
			btnC2Yes.visible = false
			btnC2Yes.disabled = true
			btnYNDone.visible = true
		8:
			tmrTimer.set_one_shot(true)

			if UniversalSettings.settings_data.voice_volume > 0.01:
				tmrTimer.start(10)
			else:
				tmrTimer.start(3)

			tabCont.visible = false

	if tIn.size() > 0:
		for x in range(0, tIn.size()):
			var node = tCButtons[x]
			node.set_text(tIn[x])
			node.disabled = false
			node.visible = true

			if iYN == 0:
				node.disabled = true

		tabCol1.visible = true

		if tIn.size() > 1:
			tabCol2.visible = true

		if tIn.size() > 2:
			tabCol3.visible = true

	if tabCol1.is_visible():
		tabCont.visible = true

	txtMessage.set_text(sIn)
	txtMessage.hide()
	txtMessage.show()

	if sIn2 != "":
		sIn = sIn2

	if UniversalSettings.settings_data.voice_volume > 0.01:
		TTS.call_deferred("speak", sIn)

func startDrag():
	if TTS.is_speaking():
		TTS.stop()

	hoverPopup.visible = false
	var camera = get_tree().get_root().get_node("Spatial/Camera")
	var mousePos = get_viewport().get_mouse_position()
	var tCPRO = camera.project_ray_origin(mousePos)
	var tCPRN = camera.project_ray_normal(mousePos)
	var iL = floor(camera.position.y / cos(deg_to_rad(90 - (-1 * camera.rotation_degrees.x))))
	var dragLoc = tCPRO + tCPRN * iL
	var tObj = load(mod)
	var n = get_tree().get_root().get_node("Spatial/Buildings")
	Globals.dragObject = GDSync.multiplayer_instantiate(tObj, n, true)
	GDSync.set_gdsync_owner(n, GDSync.get_client_id())
	Globals.dragObject.set_position(dragLoc)
	Globals.dragObject.set_scale(Vector3(0.2, 0.2, 0.2))
	Globals.dragObject.set_visible(true)
	var shape = BoxShape3D.new()
	var col = CollisionShape3D.new()
	col.set_shape(shape)
	var aabb = Globals.dragObject.get_node("StaticMesh").get_mesh().get_aabb()
	shape.set_size(Vector3(abs(aabb.size.x) / 2, abs(aabb.size.y) / 2, abs(aabb.size.z) / 2))
	get_tree().get_root().get_node(Globals.dragObject.get_path()).add_child(col)
	Globals.bDrag = true

func resetDrag():
	Globals.iCurModDND = -1
	var node = get_tree().get_root().get_node("Spatial")
	node.updateNumModules(-1)
	GDSync.call_func(node.updateNumModules, [-1])
	disableBtnCon(false, Globals.iButtons)
	btnC2Yes.disabled = true
	btnC2No.disabled = true
	var sT1 = Globals.dragObject.get_path()
	Functions.freeNode(sT1)
	GDSync.call_func(Functions.freeNode, [sT1])
	Globals.dragObject.queue_free()
	Globals.bDrag = false
	Globals.dragObject = null

func btnContSpawn(iT):
	if TTS.is_speaking():
		TTS.stop()
		hoverPopup.visible = false

	mod = Globals.tAvailableMods[iT].F
	Globals.iCurModDND = Globals.tAvailableMods[iT].I
	var node = get_tree().get_root().get_node("Spatial")
	node.updateNumModules(1)
	GDSync.call_func(node.updateNumModules, [1])
	Globals.bDrag = true
	startDrag()

func _on_btnModule1_button_down():
	sfx.stream = Globals.sfx_click
	sfx.play()

	if TTS.is_speaking():
		TTS.stop()
		hoverPopup.visible = false

	if not btnCon1.is_disabled():
		if Globals.iWait == Messages.Msg.WAIT_PLACE_STARTUP or Globals.iWait == Messages.Msg.WAIT_PLACE_HABITATION:
			disableBtnCon(true, 0)
			Globals.iCurPage = 1
			btnContSpawn(1)
		elif Globals.iWait == Messages.Msg.WAIT_PLACE_MODULES or Globals.iWait == Messages.Msg.WAIT_PLACE_MORE_MODULES:
			disableBtnCon(true, 0)
			var iT = 8 * Globals.iCurPage - 7
			btnContSpawn(iT)

func _on_btnModule2_button_down():
	sfx.stream = Globals.sfx_click
	sfx.play()

	if TTS.is_speaking():
		TTS.stop()
		hoverPopup.visible = false

	if not btnCon2.is_disabled():
		if Globals.iWait == Messages.Msg.WAIT_PLACE_MODULES or Globals.iWait == Messages.Msg.WAIT_PLACE_MORE_MODULES:
			disableBtnCon(true, 0)
			var iT = 8 * Globals.iCurPage - 6
			btnContSpawn(iT)

func _on_btnModule3_button_down():
	sfx.stream = Globals.sfx_click
	sfx.play()

	if TTS.is_speaking():
		TTS.stop()
		hoverPopup.visible = false

	if not btnCon3.is_disabled():
		if Globals.iWait == Messages.Msg.WAIT_PLACE_MODULES or Globals.iWait == Messages.Msg.WAIT_PLACE_MORE_MODULES:
			disableBtnCon(true, 0)
			var iT = 8 * Globals.iCurPage - 5
			btnContSpawn(iT)

func _on_btnModule4_button_down():
	sfx.stream = Globals.sfx_click
	sfx.play()

	if TTS.is_speaking():
		TTS.stop()
		hoverPopup.visible = false

	if not btnCon4.is_disabled():
		if Globals.iWait == Messages.Msg.WAIT_PLACE_MODULES or Globals.iWait == Messages.Msg.WAIT_PLACE_MORE_MODULES:
			disableBtnCon(true, 0)
			var iT = 8 * Globals.iCurPage - 4
			btnContSpawn(iT)

func _on_btnModule5_button_down():
	sfx.stream = Globals.sfx_click
	sfx.play()

	if TTS.is_speaking():
		TTS.stop()
		hoverPopup.visible = false

	if not btnCon5.is_disabled():
		if Globals.iWait == Messages.Msg.WAIT_PLACE_MODULES or Globals.iWait == Messages.Msg.WAIT_PLACE_MORE_MODULES:
			disableBtnCon(true, 0)
			var iT = 8 * Globals.iCurPage - 3
			btnContSpawn(iT)

func _on_btnModule6_button_down():
	sfx.stream = Globals.sfx_click
	sfx.play()

	if TTS.is_speaking():
		TTS.stop()
		hoverPopup.visible = false

	if not btnCon6.is_disabled():
		if Globals.iWait == Messages.Msg.WAIT_PLACE_MODULES or Globals.iWait == Messages.Msg.WAIT_PLACE_MORE_MODULES:
			disableBtnCon(true, 0)
			var iT = 8 * Globals.iCurPage - 2
			btnContSpawn(iT)

func _on_btnModule7_button_down():
	sfx.stream = Globals.sfx_click
	sfx.play()

	if TTS.is_speaking():
		TTS.stop()
		hoverPopup.visible = false

	if not btnCon7.is_disabled():
		if Globals.iWait == Messages.Msg.WAIT_PLACE_MODULES or Globals.iWait == Messages.Msg.WAIT_PLACE_MORE_MODULES:
			disableBtnCon(true, 0)
			var iT = 8 * Globals.iCurPage - 1
			btnContSpawn(iT)

func _on_btnModule8_button_down():
	sfx.stream = Globals.sfx_click
	sfx.play()

	if TTS.is_speaking():
		TTS.stop()
		hoverPopup.visible = false

	if not btnCon8.is_disabled():
		if Globals.iWait == Messages.Msg.WAIT_PLACE_MODULES or Globals.iWait == Messages.Msg.WAIT_PLACE_MORE_MODULES:
			disableBtnCon(true, 0)
			var iT = 8 * Globals.iCurPage
			btnContSpawn(iT)

func _on_btnModuleLeft_pressed():
	sfx.stream = Globals.sfx_click
	sfx.play()

	if not btnLeft.is_disabled():
		if Globals.iCurPage > 1:
			Globals.iCurPage -= 1
			setMods()

func _on_btnModulePage_pressed():
	sfx.stream = Globals.sfx_click
	sfx.play()

	if not btnPage.is_disabled():
		Globals.iCurPage = 1
		setMods()

func _on_btnModuleRight_pressed():
	sfx.stream = Globals.sfx_click
	sfx.play()

	if not btnRight.is_disabled():
		if Globals.iCurPage < 3:
			Globals.iCurPage += 1
			setMods()

func _on_C21_pressed():
	btnC2(1)

func _on_C22_pressed():
	btnC2(2)

func _on_C23_pressed():
	btnC2(3)

func _on_C24_pressed():
	btnC2(4)

func _on_C25_pressed():
	btnC2(5)

func _on_C26_pressed():
	btnC2(6)

func _on_C27_pressed():
	btnC2(7)

func _on_C28_pressed():
	btnC2(8)

func _on_C29_pressed():
	btnC2(9)

func _on_C210_pressed():
	btnC2(10)

func _on_C211_pressed():
	btnC2(11)

func btnC2(iIn):
	sfx.stream = Globals.sfx_click
	sfx.play()

	var sT = Messages.Msg2Txt(Globals.iWait)
	global.myDebug({"iWait": sT, "iIn": iIn})
	if TTS.is_speaking():
		TTS.stop()
		hoverPopup.visible = false

	match Globals.iWait:
		Messages.Msg.PRODUCTION:
			btnCProduction(iIn)
		Messages.Msg.DICE_RANDOM_EVENT:
			btnCRandomEventDice(iIn)
		Messages.Msg.SELL_COMMODITIES:
			btnCSellCommodity(iIn)
		Messages.Msg.LAW_OFFICE_WHO:
			btnCLawOffice(iIn)
		Messages.Msg.VETERINARY_DICE_ONE, Messages.Msg.VETERINARY_DICE_TWO:
			btnCVet(iIn)
		Messages.Msg.SELL_GIFT_BOXES:
			btnCGiftBoxes(iIn)
		_:
			hoverPopup.visible = false

func _on_C2Done_pressed():
	sfx.stream = Globals.sfx_click
	sfx.play()

	var sT = Messages.Msg2Txt(Globals.iWait)
	global.myDebug({"iWait": sT})
	if TTS.is_speaking():
		TTS.stop()
		hoverPopup.visible = false

	btnC2Yes.disabled = true
	btnC2No.disabled = true
	btnC2Done.disabled = true
	btnC2Done.visible = false
	tabCont.visible = false
	Globals.bDrag = false
	disableBtnCon(true, 0)
	clearBtnCon()
	Globals.iModules = 0

	match Globals.iWait:
		Messages.Msg.WAIT_PLACE_MODULES, Messages.Msg.WAIT_PLACE_MORE_MODULES, Messages.Msg.WAIT_PLACE_HABITATION:
			if Globals.iCurModDND > -1:
				disableButtons()
				var iBuild = Globals.iCurModDND
				var xMod
				Globals.iCurModDND = -1
				Globals.bDrag = false
				global.updateModels(Globals.iPlacedX, Globals.iPlacedY, Globals.dragObject.get_name())
				GDSync.call_func(global.updateModels, [Globals.iPlacedX, Globals.iPlacedY, Globals.dragObject.get_name()])
				Globals.dragObject = null
				global.updateBuildings(Globals.iPlacedX, Globals.iPlacedY, iBuild)
				GDSync.call_func(global.updateBuildings, [Globals.iPlacedX, Globals.iPlacedY, iBuild])

				for x in Globals.tAvailableMods:
					if x.I == iBuild:
						xMod = x
						break

				match iBuild:
					4, 34, 64, 94:
						updateCatalog()
						GDSync.call_func(updateCatalog)
					5, 35, 65, 95:
						updatePortal()
						GDSync.call_func(updatePortal)
					6, 36, 66, 96:
						updateConstruction()
						GDSync.call_func(updateConstruction)
					21, 51, 81, 111:
						updateCheeseLab()
						GDSync.call_func(updateCheeseLab)
					22, 52, 82, 112:
						updateSausageLab()
						GDSync.call_func(updateSausageLab)
					23, 53, 83, 113:
						updatePastureDome()
						GDSync.call_func(updatePastureDome)
					24, 54, 84, 114:
						updateLawOffice()
						GDSync.call_func(updateLawOffice)

				if global.tConstruction[Globals.iMyPN]:
					xMod.CO -= 1

				if global.tBoard[Globals.iPlacedX][Globals.iPlacedY] == 4 or global.tBoard[Globals.iPlacedX][Globals.iPlacedY] == 5:
					if iBuild == 17 or iBuild == 47 or iBuild == 77 or iBuild == 107:
						xMod.OU += 2
					elif iBuild == 18 or iBuild == 48 or iBuild == 78 or iBuild == 108:
						xMod.OU += 4

				for x in global.tMods:
					if x.id == iBuild:
						x.max -= 1
						break

				global.updateModules(Globals.iPlacedX, Globals.iPlacedY, 0, "N")
				GDSync.call_func(global.updateModules, [Globals.iPlacedX, Globals.iPlacedY, 0, "N"])
				global.updateModules(Globals.iPlacedX, Globals.iPlacedY, 1, "Y")
				GDSync.call_func(global.updateModules, [Globals.iPlacedX, Globals.iPlacedY, 1, "Y"])
				global.updateModules(Globals.iPlacedX, Globals.iPlacedY, 2, 0)
				GDSync.call_func(global.updateModules, [Globals.iPlacedX, Globals.iPlacedY, 2, 0])
				global.updateModules(Globals.iPlacedX, Globals.iPlacedY, 3, xMod.CO)
				GDSync.call_func(global.updateModules, [Globals.iPlacedX, Globals.iPlacedY, 3, xMod.CO])
				global.updateModules(Globals.iPlacedX, Globals.iPlacedY, 4, xMod.CA)
				GDSync.call_func(global.updateModules, [Globals.iPlacedX, Globals.iPlacedY, 4, xMod.CA])
				global.updateModules(Globals.iPlacedX, Globals.iPlacedY, 5, xMod.EP)
				GDSync.call_func(global.updateModules, [Globals.iPlacedX, Globals.iPlacedY, 5, xMod.EP])
				global.updateModules(Globals.iPlacedX, Globals.iPlacedY, 6, xMod.ER)
				GDSync.call_func(global.updateModules, [Globals.iPlacedX, Globals.iPlacedY, 6, xMod.ER])
				global.updateModules(Globals.iPlacedX, Globals.iPlacedY, 7, xMod.OU)
				GDSync.call_func(global.updateModules, [Globals.iPlacedX, Globals.iPlacedY, 7, xMod.OU])

			Globals.iWait = Messages.Msg.MODULES_PLACED
			GDSync.call_func(global.updateiWait, [Globals.iWait])
		Messages.Msg.WAIT_MOVE_MODULES, Messages.Msg.WAIT_MOVE_MODULE:
			disableButtons()
			Globals.bDrag = false

			if Globals.bModuleMoved:
				global.tBank[Globals.iMyPN] -= floor(global.tModules[Globals.iConX][Globals.iConY].cost / 2.0)
				await(updateBank(Globals.iMyPN, global.tBank[Globals.iMyPN]))
				GDSync.call_func(updateBank, [Globals.iMyPN, global.tBank[Globals.iMyPN]])

			Globals.iWait = Messages.Msg.MODULE_MOVED
			GDSync.call_func(global.updateiWait, [Globals.iWait])
		Messages.Msg.WAIT_NEW_DISEASE:
			if global.iSick == 1:
				Globals.iWait = Messages.Msg.DISEASE_DONE
				GDSync.call_func(global.updateiWait, [Globals.iWait])
			else:
				sTxt = "[DISEASE][br]You still have to mark at least one Barn, or MegaBarn as Sick!"
				await(updateGUI(sTxt, [], 1))
		Messages.Msg.WAIT_ENERGY_DEFICIT:
			var res = Functions.calculateEnergy()

			if res.D < 0:
				sTxt = "[ENERGY][br]You still have a DEFICIT of " + str(res.D) + "![br]Please mark at least one module as offline and then press DONE to finish your turn."
				await(updateGUI(sTxt, [], 6))
			else:
				disableButtons()
				Globals.iWait = Messages.Msg.ENERGY_DONE
				GDSync.call_func(global.updateiWait, [Globals.iWait])
		Messages.Msg.WAIT_ENERGY_SURPLUS:
			var res = Functions.calculateEnergy()

			if res.D > 0 and res.S <= res.D:
				sTxt = "[ENERGY][br]You still have a SURPLUS of " + str(res.D) + " and also at least one module offline that can be brought back online![br]Would you like to do this?"
				await(updateGUI(sTxt, [], 2))
				Globals.iWait = Messages.Msg.WAIT_ENERGY_YN
				GDSync.call_func(global.updateiWait, [Globals.iWait])
			else:
				disableButtons()
				Globals.iWait = Messages.Msg.ENERGY_DONE
				GDSync.call_func(global.updateiWait, [Globals.iWait])
		Messages.Msg.WAIT_ENERGY_YN:
			disableButtons()
			Globals.iWait = Messages.Msg.ENERGY_DONE
			GDSync.call_func(global.updateiWait, [Globals.iWait])
		Messages.Msg.WAIT_PRODUCTION:
			disableButtons()
			Globals.iWait = Messages.Msg.PRODUCTION_DONE
			GDSync.call_func(global.updateiWait, [Globals.iWait])
		Messages.Msg.SELL_COMMODITIES:
			disableButtons()

			if Globals.iCommodityCount < 9:
				Functions.sellCommodity()
			else:
				Globals.iCommodityCount = 0
				Globals.iWait = Messages.Msg.COMMODITY_PRICES_DONE
				GDSync.call_func(global.updateiWait, [Globals.iWait])
		Messages.Msg.SELL_GIFT_BOXES:
			disableBtnCon(true, 0)
			clearBtnCon()
			var iC = 0

			if Globals.iGiftSell > 0:
				iC = 10

				if Globals.tREOther[Globals.iMyPN].giftboxes > 0:
					iC = Globals.tREOther[Globals.iMyPN].giftboxes

				sTxt = "[GIFT BOXES][br]You have sold " + Globals.iGiftSell + " gift boxes at " + iC + " dollars each."
				await(updateGUI(sTxt, [], 3))
				Globals.iWait = Messages.Msg.GIFT_BOXES_DONE
				GDSync.call_func(global.updateiWait, [Globals.iWait])
			else:
				sTxt = "[GIFT BOXES][br]Are you sure you do not wish to sell any Gift Boxes?"
				await(updateGUI(sTxt, [], 2))
				Globals.iWait = Messages.Msg.GIFT_BOX_SELL
				GDSync.call_func(global.updateiWait, [Globals.iWait])
		Messages.Msg.LAW_OFFICE_WHO:
			disableButtons()
			Globals.iWait = Messages.Msg.LAW_OFFICE_DONE
			GDSync.call_func(global.updateiWait, [Globals.iWait])
		Messages.Msg.VETERINARY_DICE_ONE:
			if Globals.iCount == 0:
				disableButtons()
				Globals.iWait = Messages.Msg.VETERINARY_DONE
				GDSync.call_func(global.updateiWait, [Globals.iWait])
		Messages.Msg.VETERINARY_DICE_TWO:
			if Globals.iCount == 0 and global.tNumRolls[global.iCurPlay] == 2:
				global.tNumRolls[global.iCurPlay] = 1
				Functions.veterinaryReroll()
			else:
				disableButtons()
				Globals.iWait = Messages.Msg.VETERINARY_DONE
				GDSync.call_func(global.updateiWait, [Globals.iWait])
		Messages.Msg.LOSE_GEOTHERMAL:
			var iG = 0
			var tNum = 30 * global.iCurPlay - 27

			for x in range(1, 17):
				for y in range(1, 13):
					if global.tBuildings[x][y] == tNum:
						if global.tModules[x][y].online == "Y":
							iG += 1

			if iG != Globals.iGeothermal - 1:
				sTxt = "[RANDOM EVENT][br]You have not marked a Geothermal Powerplant as offline![br]Please try again."
				await(updateGUI(sTxt))
			else:
				disableButtons()
				Globals.iWait = Messages.Msg.RANDOM_EVENT_DONE
				GDSync.call_func(global.updateiWait, [Globals.iWait])
		Messages.Msg.LOSE_CRYSTAL:
			var iC = 0
			var tNum = 30 * global.iCurPlay - 28

			for x in range(1, 17):
				for y in range(1, 13):
					if global.tBuildings[x][y] == tNum:
						if global.tModules[x][y].online == "Y":
							iC += 1

			if iC != Globals.iCrystal - 1:
				sTxt = "[RANDOM EVENT][br]You have not marked a Crystal Powerplant as offline![br]Please try again."
				await(updateGUI(sTxt))
			else:
				disableButtons()
				Globals.iWait = Messages.Msg.RANDOM_EVENT_DONE
				GDSync.call_func(global.updateiWait, [Globals.iWait])
		Messages.Msg.SICK_BARN:
			var iB = 0
			var tNum = 30 * global.iCurPlay - 13

			for x in range(1, 17):
				for y in range(1, 13):
					if global.tBuildings[x][y] == tNum:
						if global.tModules[x][y].sick == "Y":
							iB += 1

			if iB != Globals.iBarn + 1:
				sTxt = "[RANDOM EVENT][br]You have not marked a Barn as sick![br]Please try again."
				await(updateGUI(sTxt))
			else:
				disableButtons()
				Globals.iWait = Messages.Msg.RANDOM_EVENT_DONE
				GDSync.call_func(global.updateiWait, [Globals.iWait])
		Messages.Msg.SICK_MEGABARN:
			var iM = 0
			var tNum = 30 * global.iCurPlay - 12

			for x in range(1, 17):
				for y in range(1, 13):
					if global.tBuildings[x][y] == tNum:
						if global.tModules[x][y].sick == "Y":
							iM += 1

			if iM != Globals.iMegaBarn + 1:
				sTxt = "[RANDOM EVENT][br]You have not marked a MegaBarn as sick![br]Please try again."
				await(updateGUI(sTxt))
			else:
				disableButtons()
				Globals.iWait = Messages.Msg.RANDOM_EVENT_DONE
				GDSync.call_func(global.updateiWait, [Globals.iWait])
		Messages.Msg.REMOVE_BARN:
			var iB = 0
			var tNum1 = 30 * global.iCurPlay - 13
			var tNum2 = 30 * global.iCurPlay - 12

			for x in range(1, 17):
				for y in range(1, 13):
					if global.tBuildings[x][y] == tNum1 or global.tBuildings[x][y] == tNum2:
						iB += 1

			if iB != Globals.iBarn - 1:
				sTxt = "[RANDOM EVENT][br]You have not removed a Barn or Megabarn![br]Please try again."
				await(updateGUI(sTxt))
			else:
				disableButtons()
				Globals.iWait = Messages.Msg.RANDOM_EVENT_DONE
				GDSync.call_func(global.updateiWait, [Globals.iWait])

func _on_C2Yes_pressed():
	sfx.stream = Globals.sfx_click
	sfx.play()

	var sT = Messages.Msg2Txt(Globals.iWait)
	global.myDebug({"iWait": sT})
	if TTS.is_speaking():
		TTS.stop()
		hoverPopup.visible = false

	match Globals.iWait:
		Messages.Msg.WAIT_PLACE_STARTUP:
			disableButtons()
			Globals.bDrag = false
			var iBuild = 30 * Globals.iMyPN - 29
			Globals.iCurModDND = -1
			global.updateModels(Globals.iPlacedX, Globals.iPlacedY, Globals.dragObject.get_name())
			GDSync.call_func(global.updateModels, [Globals.iPlacedX, Globals.iPlacedY, Globals.dragObject.get_name()])
			Globals.dragObject = null
			global.updateModules(Globals.iPlacedX, Globals.iPlacedY, 0, "N")
			GDSync.call_func(global.updateModules, [Globals.iPlacedX, Globals.iPlacedY, 0, "N"])
			global.updateModules(Globals.iPlacedX, Globals.iPlacedY, 1, "Y")
			GDSync.call_func(global.updateModules, [Globals.iPlacedX, Globals.iPlacedY, 1, "Y"])
			global.updateModules(Globals.iPlacedX, Globals.iPlacedY, 2, 0)
			GDSync.call_func(global.updateModules, [Globals.iPlacedX, Globals.iPlacedY, 2, 0])
			global.updateModules(Globals.iPlacedX, Globals.iPlacedY, 3, 2)
			GDSync.call_func(global.updateModules, [Globals.iPlacedX, Globals.iPlacedY, 3, 2])
			global.updateModules(Globals.iPlacedX, Globals.iPlacedY, 4, 2)
			GDSync.call_func(global.updateModules, [Globals.iPlacedX, Globals.iPlacedY, 4, 2])
			global.updateModules(Globals.iPlacedX, Globals.iPlacedY, 5, 2)
			GDSync.call_func(global.updateModules, [Globals.iPlacedX, Globals.iPlacedY, 5, 2])
			global.updateModules(Globals.iPlacedX, Globals.iPlacedY, 6, 0)
			GDSync.call_func(global.updateModules, [Globals.iPlacedX, Globals.iPlacedY, 6, 0])
			global.updateModules(Globals.iPlacedX, Globals.iPlacedY, 7, 0)
			GDSync.call_func(global.updateModules, [Globals.iPlacedX, Globals.iPlacedY, 7, 0])
			global.updateBuildings(Globals.iPlacedX, Globals.iPlacedY, iBuild)
			GDSync.call_func(global.updateBuildings, [Globals.iPlacedX, Globals.iPlacedY, iBuild])

			for x in global.tMods:
				if x.id == iBuild:
					x.max -= 1
					break

			global.tBank[Globals.iMyPN] -= 20
			await(updateBank(Globals.iMyPN, global.tBank[Globals.iMyPN]))
			GDSync.call_func(updateBank, [Globals.iMyPN, global.tBank[Globals.iMyPN]])
			Globals.iWait = Messages.Msg.STARTUP_PLACED
			GDSync.call_func(global.updateiWait, [Globals.iWait])
		Messages.Msg.WAIT_CONSTRUCTION:
			disableButtons()
			Globals.bDrag = false
			Globals.dragObject = null
			Globals.iCurModDND = -1
			Globals.iWait = Messages.Msg.MODULE_MOVED
			GDSync.call_func(global.updateiWait, [Globals.iWait])
		Messages.Msg.WAIT_PLACE_MORE_MODULES, Messages.Msg.WAIT_PLACE_MODULES, Messages.Msg.WAIT_PLACE_HABITATION:
			disableButtons()
			var iBuild = Globals.iCurModDND
			var xMod
			Globals.iCurModDND = -1
			Globals.iModules -= 1
			Globals.bDrag = false
			global.updateModels(Globals.iPlacedX, Globals.iPlacedY, Globals.dragObject.get_name())
			GDSync.call_func(global.updateModels, [Globals.iPlacedX, Globals.iPlacedY, Globals.dragObject.get_name()])
			Globals.dragObject = null
			global.updateBuildings(Globals.iPlacedX, Globals.iPlacedY, iBuild)
			GDSync.call_func(global.updateBuildings, [Globals.iPlacedX, Globals.iPlacedY, iBuild])

			for x in Globals.tAvailableMods:
				if x.I == iBuild:
					xMod = x
					break

			match iBuild:
				4, 34, 64, 94:
					updateCatalog()
					GDSync.call_func(updateCatalog)
				5, 35, 65, 95:
					updatePortal()
					GDSync.call_func(updatePortal)
				6, 36, 66, 96:
					updateConstruction()
					GDSync.call_func(updateConstruction)
				21, 51, 81, 111:
					updateCheeseLab()
					GDSync.call_func(updateCheeseLab)
				22, 52, 82, 112:
					updateSausageLab()
					GDSync.call_func(updateSausageLab)
				23, 53, 83, 113:
					updatePastureDome()
					GDSync.call_func(updatePastureDome)
				24, 54, 84, 114:
					updateLawOffice()
					GDSync.call_func(updateLawOffice)

			if global.tConstruction[Globals.iMyPN]:
				xMod.CO -= 1

			if global.tBoard[Globals.iPlacedX][Globals.iPlacedY] == 4 or global.tBoard[Globals.iPlacedX][Globals.iPlacedY] == 5:
				if iBuild == 17 or iBuild == 47 or iBuild == 77 or iBuild == 107:
					xMod.OU += 2
				elif iBuild == 18 or iBuild == 48 or iBuild == 78 or iBuild == 108:
					xMod.OU += 4

			for x in global.tMods:
				if x.id == iBuild:
					x.max -= 1
					break

			global.updateModules(Globals.iPlacedX, Globals.iPlacedY, 0, "N")
			GDSync.call_func(global.updateModules, [Globals.iPlacedX, Globals.iPlacedY, 0, "N"])
			global.updateModules(Globals.iPlacedX, Globals.iPlacedY, 1, "Y")
			GDSync.call_func(global.updateModules, [Globals.iPlacedX, Globals.iPlacedY, 1, "Y"])
			global.updateModules(Globals.iPlacedX, Globals.iPlacedY, 2, 0)
			GDSync.call_func(global.updateModules, [Globals.iPlacedX, Globals.iPlacedY, 2, 0])
			global.updateModules(Globals.iPlacedX, Globals.iPlacedY, 3, xMod.CO)
			GDSync.call_func(global.updateModules, [Globals.iPlacedX, Globals.iPlacedY, 3, xMod.CO])
			global.updateModules(Globals.iPlacedX, Globals.iPlacedY, 4, xMod.CA)
			GDSync.call_func(global.updateModules, [Globals.iPlacedX, Globals.iPlacedY, 4, xMod.CA])
			global.updateModules(Globals.iPlacedX, Globals.iPlacedY, 5, xMod.EP)
			GDSync.call_func(global.updateModules, [Globals.iPlacedX, Globals.iPlacedY, 5, xMod.EP])
			global.updateModules(Globals.iPlacedX, Globals.iPlacedY, 6, xMod.ER)
			GDSync.call_func(global.updateModules, [Globals.iPlacedX, Globals.iPlacedY, 6, xMod.ER])
			global.updateModules(Globals.iPlacedX, Globals.iPlacedY, 7, xMod.OU)
			GDSync.call_func(global.updateModules, [Globals.iPlacedX, Globals.iPlacedY, 7, xMod.OU])
			global.tBank[Globals.iMyPN] -= xMod.CO
			await(updateBank(Globals.iMyPN, global.tBank[Globals.iMyPN]))
			GDSync.call_func(updateBank, [Globals.iMyPN, global.tBank[Globals.iMyPN]])

			if Globals.iModules > 0:
				Globals.iWait = Messages.Msg.WAIT_PLACE_MODULES
				Functions.placeModules(false)
			else:
				sTxt = "[PLACE MODULES][br]You have placed your last module![br]Press DONE to finish your turn."
				await(updateGUI(sTxt, [], 6))
		Messages.Msg.WAIT_NO_MODULES:
			disableButtons()
			Globals.bDrag = false
			Globals.iCurModDND = -1
			Globals.dragObject = null
			Globals.iWait = Messages.Msg.MODULES_PLACED
			GDSync.call_func(global.updateiWait, [Globals.iWait])
		Messages.Msg.WAIT_NO_DISEASE:
			disableButtons()
			Globals.iWait = Messages.Msg.DISEASE_DONE
			GDSync.call_func(global.updateiWait, [Globals.iWait])
		Messages.Msg.DICE_DISEASE:
			randomize()
			var iRnd = randi() % 6 + 1

			if iRnd == 1:
				sTxt = "[DISEASE][br]Unlucky! You rolled a 1! A new disease has broken out! Select the barn, or megabarn, to mark as sick.[br]Press DONE when finished."
				await(updateGUI(sTxt, [], 6))
				Globals.iWait = Messages.Msg.WAIT_NEW_DISEASE
			else:
				sTxt = "[DISEASE][br]Lucky! You rolled a " + str(iRnd) + "! No new disease has broken out.[br]Press OK to continue."
				await(updateGUI(sTxt))
				Globals.iWait = Messages.Msg.WAIT_NO_DISEASE
		Messages.Msg.WAIT_ENERGY:
			disableButtons()
			Globals.iWait = Messages.Msg.ENERGY_DONE
			GDSync.call_func(global.updateiWait, [Globals.iWait])
		Messages.Msg.WAIT_ENERGY_YN:
			disableButtons()
			Globals.iWait = Messages.Msg.WAIT_ENERGY_SURPLUS
			GDSync.call_func(global.updateiWait, [Globals.iWait])
		Messages.Msg.RE_OUTCOME:
			disableButtons()
			Globals.iWait = Messages.Msg.RANDOM_EVENT_DONE
			GDSync.call_func(global.updateiWait, [Globals.iWait])
		Messages.Msg.GIFT_BOX_SELL:
			global.tBank[Globals.iMyPN] += Globals.iGiftSell * Globals.tREOther[global.iCurPlay].giftboxes
			await(updateBank(Globals.iMyPN, global.tBank[Globals.iMyPN]))
			GDSync.call_func(updateBank, [Globals.iMyPN, global.tBank[Globals.iMyPN]])
			global.tREStorage[global.iCurPlay].cheese -= Globals.iGiftSell
			global.tREStorage[global.iCurPlay].beef -= Globals.iGiftSell
			disableButtons()
			Globals.iWait = Messages.Msg.GIFT_BOXES_DONE
			GDSync.call_func(global.updateiWait, [Globals.iWait])
		Messages.Msg.NO_GIFT_BOXES:
			disableButtons()
			Globals.iWait = Messages.Msg.GIFT_BOXES_DONE
			GDSync.call_func(global.updateiWait, [Globals.iWait])
		Messages.Msg.NO_COMMODITIES:
			disableButtons()
			Globals.iWait = Messages.Msg.COMMODITY_PRICES_DONE
			GDSync.call_func(global.updateiWait, [Globals.iWait])
		Messages.Msg.OTHER_INCOME_OK:
			disableButtons()
			Globals.iWait = Messages.Msg.OTHER_INCOME_DONE
			GDSync.call_func(global.updateiWait, [Globals.iWait])
		Messages.Msg.NO_LAW_OFFICE, Messages.Msg.LAW_OFFICE_NO_SUE, Messages.Msg.SUE_DICE_DONE:
			disableButtons()
			Globals.iWait = Messages.Msg.LAW_OFFICE_DONE
			GDSync.call_func(global.updateiWait, [Globals.iWait])
		Messages.Msg.LAW_OFFICE_SUE:
			disableButtons()
			Functions.sueDice()
		Messages.Msg.NO_VETERINARY:
			disableButtons()
			Globals.iWait = Messages.Msg.VETERINARY_DONE
			GDSync.call_func(global.updateiWait, [Globals.iWait])
		Messages.Msg.WAIT_RESET:
			disableButtons()
			Globals.iWait = Messages.Msg.RESET_COMMODITIES_DONE
			GDSync.call_func(global.updateiWait, [Globals.iWait])
		Messages.Msg.WAIT_END_OF_ROUND:
			disableButtons()
			Globals.iWait = Messages.Msg.END_OF_ROUND_DONE
			GDSync.call_func(global.updateiWait, [Globals.iWait])
		Messages.Msg.WAIT_END_OF_GAME:
			Globals.iWait = Messages.Msg.QUIT_GAME
		Messages.Msg.TIED_GAME:
			disableButtons()
			Globals.iWait = Messages.Msg.WAIT_TIED_GAME
			sTxt = "[TIED GAME][br]You have voted to continue playing."
			await(updateGUI(sTxt, [], 3))
			Functions.updateVote(2)
		_:
			hoverPopup.visible = false

func disableButtons():
	disableBtnCon(true, 0)
	clearBtnCon()
	btnC2Yes.disabled = true
	btnC2Done.disabled = true
	btnC2No.disabled = true
	tabCont.visible = false

func _on_C2No_pressed():
	sfx.stream = Globals.sfx_click
	sfx.play()

	var sT = Messages.Msg2Txt(Globals.iWait)
	global.myDebug({"iWait": sT})
	if TTS.is_speaking():
		TTS.stop()
		hoverPopup.visible = false

	match Globals.iWait:
		Messages.Msg.WAIT_PLACE_STARTUP:
			Functions.updateAvailArea(Globals.iAvailArea, true)
			GDSync.call_func(Functions.updateAvailArea, [Globals.iAvailArea, true])
			Globals.iCurModDND = -1
			disableButtons()
			var sT1 = Globals.dragObject.get_path()
			Functions.freeNode(sT1)
			GDSync.call_func(Functions.freeNode, [sT1])
			Globals.dragObject.queue_free()
			Globals.bDrag = false
			Globals.dragObject = null
			updateButtons()
			sTxt = "[PLACE STARTUP][br]It's still your turn! Please drag the Startup module onto the board."
			await(updateGUI(sTxt, [], 0))
		Messages.Msg.WAIT_MOVE_MODULES:
			if Globals.bDrag:
				for x in range(1, 17):
					for y in range(1, 13):
						if global.tBuildings[x][y] == Globals.iCurModDND:
							var xx = global.tBoardLoc[x][y][0]
							var zz = global.tBoardLoc[x][y][1]
							Globals.dragObject.position.x = xx
							Globals.dragObject.position.z = zz
							Functions.moveCamera(xx, zz)
							break

				Globals.iCurModDND = -1
				Globals.iModules += 1
				disableButtons()
				var sT1 = Globals.dragObject.get_path()
				Functions.freeNode(sT1)
				GDSync.call_func(Functions.freeNode, [sT1])
				Globals.dragObject.queue_free()
				Globals.bDrag = false
				Globals.dragObject = null
				Globals.bModuleMoved = false
		Messages.Msg.WAIT_PLACE_HABITATION, Messages.Msg.WAIT_PLACE_MORE_MODULES:
			Globals.iCurModDND = -1
			disableButtons()
			var sT1 = Globals.dragObject.get_path()
			Functions.freeNode(sT1)
			GDSync.call_func(Functions.freeNode, [sT1])
			Globals.dragObject.queue_free()
			Globals.bDrag = false
			Globals.dragObject = null
			Globals.iWait = Messages.Msg.WAIT_PLACE_MODULES
			Functions.placeModules(false)
		Messages.Msg.WAIT_PRODUCTION:
			var iPN = global.iCurPlay
			var tStore = []

			global.tTmpStore[1] = global.tStorage[iPN].beef
			global.tTmpStore[2] = global.tStorage[iPN].butter
			global.tTmpStore[3] = global.tStorage[iPN].cheese
			global.tTmpStore[4] = global.tStorage[iPN].cream
			global.tTmpStore[5] = global.tStorage[iPN].icecream
			global.tTmpStore[6] = global.tStorage[iPN].leather
			global.tTmpStore[7] = global.tStorage[iPN].manure
			global.tTmpStore[8] = global.tStorage[iPN].milk

			tStore.push_back("Beef - " + global.tTmpStore[1] + " out of 10 Stored")
			tStore.push_back("Butter - " + global.tTmpStore[2] + " out of 10 Stored")
			tStore.push_back("Cheese - " + global.tTmpStore[3] + " out of 10 Stored")
			tStore.push_back("Cream - " + global.tTmpStore[4] + " out of 10 Stored")
			tStore.push_back("IceCream - " + global.tTmpStore[5] + " out of 10 Stored")
			tStore.push_back("Leather - " + global.tTmpStore[6] + " out of 10 Stored")
			tStore.push_back("Manure - " + global.tTmpStore[7] + " out of 10 Stored")
			tStore.push_back("Milk - " + global.tTmpStore[8] + " out of 10 Stored")

			Globals.iStoreDiff = Globals.iProduction

			sTxt = "[PRODUCTION][br]You have reset your storage! You still have " + Globals.iProduction + " left to allocate.[br]Press OK when finished."

			await(updateGUI(sTxt, tStore, 4))
		Messages.Msg.GIFT_BOX_SELL:
			Globals.iWait = Messages.Msg.SELL_GIFT_BOXES
			GDSync.call_func(global.updateiWait, [Globals.iWait])
			Functions.giftBoxes()
		Messages.Msg.WAIT_ENERGY_YN:
			disableButtons()
			Globals.iWait = Messages.Msg.ENERGY_DONE
			GDSync.call_func(global.updateiWait, [Globals.iWait])
		Messages.Msg.TIED_GAME:
			disableButtons()
			Globals.iWait = Messages.Msg.WAIT_TIED_GAME
			sTxt = "[TIED GAME][br]You have voted to end the game."
			await(updateGUI(sTxt, [], 3))
			Functions.updateVote(1)
		_:
			hoverPopup.visible = false

func disableBtnCon(bIn, iIn):
	btnCon1.disabled = true
	btnCon2.disabled = true
	btnCon3.disabled = true
	btnCon4.disabled = true
	btnCon5.disabled = true
	btnCon6.disabled = true
	btnCon7.disabled = true
	btnCon8.disabled = true
	btnCon1.visible = false
	btnCon2.visible = false
	btnCon3.visible = false
	btnCon4.visible = false
	btnCon5.visible = false
	btnCon6.visible = false
	btnCon7.visible = false
	btnCon8.visible = false

	if not bIn:
		if iIn > 0:
			btnCon1.disabled = false
			btnCon1.visible = true

		if iIn > 1:
			btnCon2.disabled = false
			btnCon2.visible = true

		if iIn > 2:
			btnCon3.disabled = false
			btnCon3.visible = true

		if iIn > 3:
			btnCon4.disabled = false
			btnCon4.visible = true

		if iIn > 4:
			btnCon5.disabled = false
			btnCon5.visible = true

		if iIn > 5:
			btnCon6.disabled = false
			btnCon6.visible = true

		if iIn > 6:
			btnCon7.disabled = false
			btnCon7.visible = true

		if iIn > 7:
			btnCon8.disabled = false
			btnCon8.visible = true

func clearBtnCon():
	btnCon1.set_texture_normal(null)
	btnCon1.set_texture_hover(null)
	btnCon1.set_texture_pressed(null)
	btnCon2.set_texture_normal(null)
	btnCon2.set_texture_hover(null)
	btnCon2.set_texture_pressed(null)
	btnCon3.set_texture_normal(null)
	btnCon3.set_texture_hover(null)
	btnCon3.set_texture_pressed(null)
	btnCon4.set_texture_normal(null)
	btnCon4.set_texture_hover(null)
	btnCon4.set_texture_pressed(null)
	btnCon5.set_texture_normal(null)
	btnCon5.set_texture_hover(null)
	btnCon5.set_texture_pressed(null)
	btnCon6.set_texture_normal(null)
	btnCon6.set_texture_hover(null)
	btnCon6.set_texture_pressed(null)
	btnCon7.set_texture_normal(null)
	btnCon7.set_texture_hover(null)
	btnCon7.set_texture_pressed(null)
	btnCon8.set_texture_normal(null)
	btnCon8.set_texture_hover(null)
	btnCon8.set_texture_pressed(null)

func _on_btnModule1_mouse_entered():
	if TTS.is_speaking():
		TTS.stop()

	if not btnCon1.disabled:
		var iXX = Globals.iCurPage * 8 - 7

		if Globals.iWait == -1:
			iXX = 1

		global.hoverText(Globals.tAvailableMods[iXX].I)

func _on_btnModule2_mouse_entered():
	if TTS.is_speaking():
		TTS.stop()

	if not btnCon2.disabled:
		var iXX = Globals.iCurPage * 8 - 6

		if Globals.iWait == -1:
			iXX = 1

		global.hoverText(Globals.tAvailableMods[iXX].I)

func _on_btnModule3_mouse_entered():
	if TTS.is_speaking():
		TTS.stop()

	if not btnCon3.disabled:
		var iXX = Globals.iCurPage * 8 - 5

		if Globals.iWait == -1:
			iXX = 1

		global.hoverText(Globals.tAvailableMods[iXX].I)

func _on_btnModule4_mouse_entered():
	if TTS.is_speaking():
		TTS.stop()

	if not btnCon4.disabled:
		var iXX = Globals.iCurPage * 8 - 4

		if Globals.iWait == -1:
			iXX = 1

		global.hoverText(Globals.tAvailableMods[iXX].I)

func _on_btnModule5_mouse_entered():
	if TTS.is_speaking():
		TTS.stop()

	if not btnCon5.disabled:
		var iXX = Globals.iCurPage * 8 - 3

		if Globals.iWait == -1:
			iXX = 1

		global.hoverText(Globals.tAvailableMods[iXX].I)

func _on_btnModule6_mouse_entered():
	if TTS.is_speaking():
		TTS.stop()

	if not btnCon6.disabled:
		var iXX = Globals.iCurPage * 8 - 2

		if Globals.iWait == -1:
			iXX = 1

		global.hoverText(Globals.tAvailableMods[iXX].I)

func _on_btnModule7_mouse_entered():
	if TTS.is_speaking():
		TTS.stop()

	if not btnCon7.disabled:
		var iXX = Globals.iCurPage * 8 - 1

		if Globals.iWait == -1:
			iXX = 1

		global.hoverText(Globals.tAvailableMods[iXX].I)

func _on_btnModule8_mouse_entered():
	if TTS.is_speaking():
		TTS.stop()

	if not btnCon8.disabled:
		var iXX = Globals.iCurPage * 8

		if Globals.iWait == -1:
			iXX = 1

		global.hoverText(Globals.tAvailableMods[iXX].I)

func _on_btn_module_1_mouse_exited() -> void:
	if TTS.is_speaking():
		TTS.stop()

	hoverPopup.visible = false

func _on_btn_module_2_mouse_exited() -> void:
	if TTS.is_speaking():
		TTS.stop()

	hoverPopup.visible = false

func _on_btn_module_3_mouse_exited() -> void:
	if TTS.is_speaking():
		TTS.stop()

	hoverPopup.visible = false

func _on_btn_module_4_mouse_exited() -> void:
	if TTS.is_speaking():
		TTS.stop()

	hoverPopup.visible = false

func _on_btn_module_5_mouse_exited() -> void:
	if TTS.is_speaking():
		TTS.stop()

	hoverPopup.visible = false

func _on_btn_module_6_mouse_exited() -> void:
	if TTS.is_speaking():
		TTS.stop()

	hoverPopup.visible = false

func _on_btn_module_7_mouse_exited() -> void:
	if TTS.is_speaking():
		TTS.stop()

	hoverPopup.visible = false

func _on_btn_module_8_mouse_exited() -> void:
	if TTS.is_speaking():
		TTS.stop()

	hoverPopup.visible = false

func _on_btnQuit_pressed():
	sfx.stream = Globals.sfx_click
	sfx.play()

	if TTS.is_speaking():
		TTS.stop()

	dlgConf.title = "Are You Sure?"
	dlgConf.dialog_text = "\nAre you sure you want to Quit the Game?"
	dlgConf.show()

func _on_lblScoreP1_pressed():
	sfx.stream = Globals.sfx_click
	sfx.play()

	var tTmp = get_tree().get_root().get_node("Spatial/Camera")
	tTmp.position = Globals.tCamPos[1]
	tTmp.rotation = Vector3(-30, 0, 0)

func _on_lblScoreP2_pressed():
	sfx.stream = Globals.sfx_click
	sfx.play()

	var tTmp = get_tree().get_root().get_node("Spatial/Camera")
	tTmp.position = Globals.tCamPos[2]
	tTmp.rotation = Vector3(-30, 0, 0)

func _on_lblScoreP3_pressed():
	sfx.stream = Globals.sfx_click
	sfx.play()

	var tTmp = get_tree().get_root().get_node("Spatial/Camera")
	tTmp.traslation = Globals.tCamPos[3]
	tTmp.rotation = Vector3(-30, 0, 0)

func _on_lblScoreP4_pressed():
	sfx.stream = Globals.sfx_click
	sfx.play()

	var tTmp = get_tree().get_root().get_node("Spatial/Camera")
	tTmp.position = Globals.tCamPos[4]
	tTmp.rotation = Vector3(-30, 0, 0)

func btnCProduction(iIn):
	var sT = Messages.Msg2Txt(Globals.iWait)
	global.myDebug({"iWait": sT, "iIn": iIn})
	if TTS.is_speaking():
		TTS.stop()
		hoverPopup.visible = false

	if global.tTmpStore[iIn] < 10 and Globals.iStoreDiff > 0:
		global.tTmpStore[iIn] += 1
		Globals.iStoreDiff -= 1

	match iIn:
		1:
			global.tStorage[global.iCurPlay].beef = global.tTmpStore[1]
		2:
			global.tStorage[global.iCurPlay].butter = global.tTmpStore[2]
		3:
			global.tStorage[global.iCurPlay].cheese = global.tTmpStore[3]
		4:
			global.tStorage[global.iCurPlay].cream = global.tTmpStore[4]
		5:
			global.tStorage[global.iCurPlay].icecream = global.tTmpStore[5]
		6:
			global.tStorage[global.iCurPlay].leather = global.tTmpStore[6]
		7:
			global.tStorage[global.iCurPlay].manure = global.tTmpStore[7]
		8:
			global.tStorage[global.iCurPlay].milk = global.tTmpStore[8]

	btnC21.set_text("BEEF: " + str(global.tStorage[global.iCurPlay].beef))
	btnC22.set_text("BUTTER: " + str(global.tStorage[global.iCurPlay].butter))
	btnC23.set_text("CHEESE: " + str(global.tStorage[global.iCurPlay].cheese))
	btnC24.set_text("CREAM: " + str(global.tStorage[global.iCurPlay].cream))
	btnC25.set_text("ICECREAM: " + str(global.tStorage[global.iCurPlay].icecream))
	btnC26.set_text("LEATHER: " + str(global.tStorage[global.iCurPlay].leather))
	btnC27.set_text("MANURE: " + str(global.tStorage[global.iCurPlay].manure))
	btnC28.set_text("MILK: " + str(global.tStorage[global.iCurPlay].milk))
	btnC21.disabled = true
	btnC22.disabled = true
	btnC23.disabled = true
	btnC24.disabled = true
	btnC25.disabled = true
	btnC26.disabled = true
	btnC27.disabled = true
	btnC28.disabled = true
	var tNum = global.iCurPlay * 30

	for x in range(1, 17):
		for y in range(1, 13):
			if global.tBuildings[x][y] == tNum - 21:
				# ENABLE BEEF
				if global.tModules[x][y].online == "N":
					btnC21.disabled = false
			elif global.tBuildings[x][y] == tNum - 20:
				# ENABLE BUTTER
				if global.tModules[x][y].online == "N":
					btnC22.disabled = false
			elif global.tBuildings[x][y] == tNum - 19:
				# ENABLE CHEESE
				if global.tModules[x][y].online == "N":
					btnC23.disabled = false
			elif global.tBuildings[x][y] == tNum - 18:
				# ENABLE CREAM
				if global.tModules[x][y].online == "N":
					btnC24.disabled = false
			elif global.tBuildings[x][y] == tNum - 17:
				# ENABLE ICECREAM
				if global.tModules[x][y].online == "N":
					btnC25.disabled = false
			elif global.tBuildings[x][y] == tNum - 16:
				# ENABLE LEATHER
				if global.tModules[x][y].online == "N":
					btnC26.disabled = false
			elif global.tBuildings[x][y] == tNum - 15:
				# ENABLE MANURE
				if global.tModules[x][y].online == "N":
					btnC27.disabled = false
			elif global.tBuildings[x][y] == tNum - 14:
				# ENABLE MILK
				if global.tModules[x][y].online == "N":
					btnC28.disabled = false

	Globals.iWait = Messages.Msg.WAIT_PRODUCTION
	sTxt = "[PRODUCTION][br]You have " + str(Globals.iStoreDiff) + " left to allocate!"
	await(updateGUI(sTxt, [], 4))

func btnCRandomEventDice(iIn):
	var sT = Messages.Msg2Txt(Globals.iWait)
	global.myDebug({"iWait": sT, "iIn": iIn})
	if TTS.is_speaking():
		TTS.stop()
		hoverPopup.visible = false

	if iIn == 1:	# Dice 1
		if not RE1:
			RE1 = true
			Globals.iDice1 = randi() % 6 + 1
			sTxt = "[RANDOM EVENT][br]You rolled a " + str(Globals.iDice1) + " for Dice 1!"
			await(updateGUI(sTxt, ["Dice1", "Dice2"], 3))
			btnC21.set_text(str(Globals.iDice1))
			btnC21.disabled = true
	else:			# Dice 2
		if not RE2:
			RE2 = true
			Globals.iDice2 = randi() % 6 + 1
			sTxt = "[RANDOM EVENT][br]You rolled a " + str(Globals.iDice1) + " for Dice 2!"
			await(updateGUI(sTxt, ["Dice1", "Dice2"], 0))
			btnC22.set_text(str(Globals.iDice2))
			btnC22.disabled = true

	if RE1 and RE2:
		RE1 = false
		RE2 = false
		Functions.randomEventDice()

func btnCSellCommodity(iIn):
	var sT = Messages.Msg2Txt(Globals.iWait)
	global.myDebug({"iWait": sT, "iIn": iIn})
	if TTS.is_speaking():
		TTS.stop()
		hoverPopup.visible = false

	Globals.iSales += Globals.iPrice * iIn

	if Globals.iCommodityCount > 8:
		global.tBank[Globals.iMyPN] += Globals.iSales
		await(updateBank(Globals.iMyPN, global.tBank[Globals.iMyPN]))
		GDSync.call_func(updateBank, [Globals.iMyPN, global.tBank[Globals.iMyPN]])
		Globals.iSales = 0
		Globals.iPrice = 0
		disableButtons()
		Globals.iWait = Messages.Msg.COMMODITY_PRICES_DONE
		GDSync.call_func(global.updateiWait, [Globals.iWait])
	else:
		Functions.sellCommodity()
		Globals.iPrice = 0

func btnCLawOffice(iIn):
	var sT = Messages.Msg2Txt(Globals.iWait)
	global.myDebug({"iWait": sT, "iIn": iIn})
	if TTS.is_speaking():
		TTS.stop()
		hoverPopup.visible = false

	var sTmp = "NO-ONE"
	Globals.iSue = 0

	if iIn == 1:
		sTmp = btnC21.get_text()
	elif iIn == 2:
		sTmp = btnC22.get_text()
	elif iIn == 3:
		sTmp = btnC23.get_text()
	elif iIn == 4:
		sTmp = btnC24.get_text()

	if sTmp != "NO-ONE":
		for x in range(1, GDSync.get_lobby_player_limit() + 1):
			if global.tOOP[x].name == sTmp:
				Globals.iSue = global.tOOP[x].playnum

		Globals.iWait = Messages.Msg.LAW_OFFICE_SUE
		sTxt = "[LAW OFFICE][br]You are about to sue " + global.tOOP[Globals.iSue].name + "![br]Press OK to roll the dice."
		await(updateGUI(sTxt))
	else:
		Globals.iWait = Messages.Msg.LAW_OFFICE_NO_SUE
		sTxt = "[LAW OFFICE][br]You have decided not to sue anyone![br]Press OK to continue."
		await(updateGUI(sTxt))

func btnCVet(iIn):
	var sT = Messages.Msg2Txt(Globals.iWait)
	global.myDebug({"iWait": sT, "iIn": iIn})
	if TTS.is_speaking():
		TTS.stop()
		hoverPopup.visible = false

	var iD = randi() % 6 + 1

	if iIn == 1:
		btnC21.text = str(iD)
		btnC21.disabled = true
	elif iIn == 2:
		btnC22.text = str(iD)
		btnC22.disabled = true
	elif iIn == 3:
		btnC23.text = str(iD)
		btnC23.disabled = true
	elif iIn == 4:
		btnC24.text = str(iD)
		btnC24.disabled = true

	Globals.iCount -= 1

	if iD >= 5:
		var loc = global.tBarns[iIn - 1]
		global.updateModules(loc.x, loc.y, 0, "N")
		GDSync.call_func(global.updateModules, [loc.x, loc.y, 0, "N"])
		var sT1 = "Spatial/Buildings/" + str(global.tModels[loc.x][loc.y]) + "/" + str(global.tSickIcons[loc.x][loc.y])
		Functions.freeNode(sT1)
		GDSync.call_func(Functions.freeNode, [sT1])
		var sIcon = get_tree().get_root().get_node(sT1)
		sIcon.queue_free()
		global.tSickIcons[loc.x][loc.y] = -1
		global.iNumDisease[global.iCurPlay] -= 1

func btnCGiftBoxes(iIn):
	var sT = Messages.Msg2Txt(Globals.iWait)
	global.myDebug({"iWait": sT, "iIn": iIn})
	if TTS.is_speaking():
		TTS.stop()
		hoverPopup.visible = false

	Globals.iGiftSell = iIn - 1
	Globals.iWait = Messages.Msg.GIFT_BOX_SELL
	sTxt = "[GIFT BOXES][br]You are about to sell " + str(Globals.iGiftSell) + " Gift Boxes at $" + str(Globals.tREOther[global.iCurPlay].giftboxes) + ".[br]Press OK to continue."
	await(updateGUI(sTxt))

func updateButtons():
	disableBtnCon(true, 0)
	clearBtnCon()

	if Globals.iModules > 0:
		var sT = ""
		var sT1 = ""
		var iT = 0
		var iStart = 0
		var iEnd = 0

		if not Globals.tAvailableMods.is_empty():
			iT = Globals.tAvailableMods.size() - 1

		if Globals.iCurPage == 3:
			if iT < 17:
				Globals.iCurPage = 2
		elif Globals.iCurPage == 2:
			if iT < 8:
				Globals.iCurPage = 1

		setMods(false)
		iEnd = iT

		if Globals.iCurPage == 1:
			iStart = 1

			if iT > 8:
				iEnd = 8
		elif Globals.iCurPage == 2:
			iStart = 9

			if iT > 16:
				iEnd = 16
		else:
			iStart = 17

		for x in range(iStart, iEnd + 1):
			sT = Globals.tAvailableMods[x].F2
			sT1 = sT + "_b.png"
			sT += ".png"
			var tTex = load(sT)
			var tTex1 = load(sT1)

			if x == (8 * Globals.iCurPage) - 7:
				btnCon1.set_texture_normal(tTex)
				btnCon1.set_texture_hover(tTex1)
				btnCon1.set_texture_pressed(tTex)
			elif x == (8 * Globals.iCurPage) - 6:
				btnCon2.set_texture_normal(tTex)
				btnCon2.set_texture_hover(tTex1)
				btnCon2.set_texture_pressed(tTex)
			elif x == (8 * Globals.iCurPage) - 5:
				btnCon3.set_texture_normal(tTex)
				btnCon3.set_texture_hover(tTex1)
				btnCon3.set_texture_pressed(tTex)
			elif x == (8 * Globals.iCurPage) - 4:
				btnCon4.set_texture_normal(tTex)
				btnCon4.set_texture_hover(tTex1)
				btnCon4.set_texture_pressed(tTex)
			elif x == (8 * Globals.iCurPage) - 3:
				btnCon5.set_texture_normal(tTex)
				btnCon5.set_texture_hover(tTex1)
				btnCon5.set_texture_pressed(tTex)
			elif x == (8 * Globals.iCurPage) - 2:
				btnCon6.set_texture_normal(tTex)
				btnCon6.set_texture_hover(tTex1)
				btnCon6.set_texture_pressed(tTex)
			elif x == (8 * Globals.iCurPage) - 1:
				btnCon7.set_texture_normal(tTex)
				btnCon7.set_texture_hover(tTex1)
				btnCon7.set_texture_pressed(tTex)
			elif x == 8 * Globals.iCurPage:
				btnCon8.set_texture_normal(tTex)
				btnCon8.set_texture_hover(tTex1)
				btnCon8.set_texture_pressed(tTex)

		if Globals.iCurPage == 2:
			iT = iEnd - 8
		elif Globals.iCurPage == 3:
			iT = iEnd - 16

		Globals.iButtons = iT
		disableBtnCon(false, iT)

func setMods(bIn = true):
	if bIn:
		updateButtons()

	btnPage.set_text(str(Globals.iCurPage))

	if Globals.iCurPage == 1:
		btnPage.disabled = true
		btnLeft.disabled = true
	else:
		btnPage.disabled = false
		btnLeft.disabled = false

	if Globals.tAvailableMods.size() > Globals.iCurPage * 8:
		btnRight.disabled = false
	else:
		btnRight.disabled = true

func _on_timer_timeout() -> void:
	txtMessage.clear()

func _on_dialog_confirmed() -> void:
	sfx.stream = Globals.sfx_click
	sfx.play()

	if Globals.bStarted:
		GDSync.call_func(Globals.playerQuit, [Globals.iMyPN])

	GDSync.quit()

func updateBank(pIn, aIn):
	var node = get_tree().get_root().get_node("Spatial")
	var sT = Messages.Msg2Txt(Globals.iWait)
	node.myDebug({"iWait": sT, "Bank": aIn})
	global.tBank[pIn] = aIn

	if pIn == 1:
		lblScoreP1.text = "$" + str(global.tBank[1])
	elif pIn == 2:
		lblScoreP2.text = "$" + str(global.tBank[2])
	elif pIn == 3:
		lblScoreP3.text = "$" + str(global.tBank[3])
	elif pIn == 4:
		lblScoreP4.text = "$" + str(global.tBank[4])

func updatePortal():
	global.tPortal[Globals.iMyPN] = true

func updateCatalog():
	global.tCatalog[Globals.iMyPN] = true

func updateConstruction():
	global.tConstruction[Globals.iMyPN] = true

func updatePastureDome():
	global.tPastureDome[Globals.iMyPN] = true

func updateCheeseLab():
	global.tCheeseLab[Globals.iMyPN] = true

func updateSausageLab():
	global.tSausageLab[Globals.iMyPN] = true

func updateLawOffice():
	global.tLawOffice[Globals.iMyPN] = true
