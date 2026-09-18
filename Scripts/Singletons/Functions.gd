extends Node

var sTxt = ""
var sTxtSpeech = ""

func _ready():
	GDSync.expose_func(orderOfPlay)
	GDSync.expose_func(sueOutcomeNot)
	GDSync.expose_func(sueOutcome)
	GDSync.expose_func(updateAvailArea)
	GDSync.expose_func(resetNumDisease)
	GDSync.expose_func(updatePrices)
	GDSync.expose_func(freeNode)
	GDSync.expose_func(playerQuit)

func getOrderOfPlay():
	var node = get_tree().get_root().get_node("Spatial")
	var tTOOP = []
	var tIC = GDSync.get_all_clients()
	Globals.iCount = 1

	for x in tIC:
		var name1 = GDSync.get_player_data(x, "Username", "Unknown")
		tTOOP.append({"id": x, "playnum": 0, "name": name1})

	randomize()
	tTOOP.shuffle()
	node.tOOP = []
	node.tOOP.append({"id": -1, "playnum": 0, "name": ""})

	for x in tTOOP:
		node.tOOP.append(x)
		node.tOOP[Globals.iCount].playnum = Globals.iCount
		Globals.iCount += 1

	sTxt = "[ORDER OF PLAY][br]The order of play is " + node.tOOP[1].name

	if GDSync.get_lobby_player_limit() == 2:
		sTxt = sTxt + ", and then " + node.tOOP[2].name
	else:
		sTxt = sTxt + ", " + node.tOOP[2].name

		if GDSync.get_lobby_player_limit() == 3:
			sTxt = sTxt + " and then " + node.tOOP[3].name
		else:
			sTxt = sTxt + ", " + node.tOOP[3].name + " and then " + node.tOOP[4].name

	Globals.iCount = 1
	GDSync.call_func(orderOfPlay, [node.tOOP, sTxt])
	var node1 = get_tree().get_root().get_node("Spatial/CanvasLayer/UI/InGame")
	await(node1.updateGUI(sTxt, [], 0))

func orderOfPlay(outTOOP, sTxt1):
	var node = get_tree().get_root().get_node("Spatial")
	node.tOOP = outTOOP
	var node1 = get_tree().get_root().get_node("Spatial/CanvasLayer/UI/InGame")
	await(node1.updateGUI(sTxt1, [], 0))

func buildBoard():
	var node = get_tree().get_root().get_node("Spatial")
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var xx = -36.35
	var zz = 36.35
	var z = false

	for x in range(1, 17):
		if x / 2.0 == floor (x / 2.0):
			z = false
		else:
			z = true

		for y in range(1, 13):
			var iRand =  rng.randi_range (0, 999)

			if iRand < 201:
				if z:
					node.tBoard[x][y] = 3
				else:
					node.tBoard[x][y] = 2
			elif iRand > 874:
				if z:
					node.tBoard[x][y] = 5
				else:
					node.tBoard[x][y] = 4
			else:
				if z:
					node.tBoard[x][y] = 1
				else:
					node.tBoard[x][y] = 0

			node.tBoardLoc[x][y][0] = xx
			node.tBoardLoc[x][y][1] = zz
			zz -= 7.27
			z = not z

		zz = 36.35
		xx += 7.27

func createBoard():
	var node = get_tree().get_root().get_node("Spatial")
	var vPos = Vector3(0.0, 0.0, 0.0)
	var vScale = Vector3(1.0, 1.0, 1.0)

	for x in range(1, 17):
		for y in range(1, 13):
			var object
			var tObj
			vPos.x = node.tBoardLoc[x][y][0]
			vPos.z = node.tBoardLoc[x][y][1]

			match node.tBoard[x][y]:
				2:
					if x < 9 and y < 7:
						tObj = load("res://Scenes/Support Scenes/square_fissure_blue.tscn")
					elif x > 8 and y < 7:
						tObj = load("res://Scenes/Support Scenes/square_fissure_green.tscn")
					elif x < 9 and y > 6:
						tObj = load("res://Scenes/Support Scenes/square_fissure_yellow.tscn")
					else:
						tObj = load("res://Scenes/Support Scenes/square_fissure_red.tscn")

					object = GDSync.multiplayer_instantiate(tObj, get_tree().get_root().get_node("Spatial/Board"), true, [], false)
					vPos.y = -0.005
				3:
					if x < 9 and y < 7:
						tObj = load("res://Scenes/Support Scenes/octagon_fissure_blue.tscn")
					elif x > 8 and y < 7:
						tObj = load("res://Scenes/Support Scenes/octagon_fissure_green.tscn")
					elif x < 9 and y > 6:
						tObj = load("res://Scenes/Support Scenes/octagon_fissure_yellow.tscn")
					else:
						tObj = load("res://Scenes/Support Scenes/octagon_fissure_red.tscn")

					object = GDSync.multiplayer_instantiate(tObj, get_tree().get_root().get_node("Spatial/Board"), true, [], false)
					vPos.y = -0.005
					vScale.x = 1.01155
					vScale.z = 1.01155
				4:
					if x < 9 and y < 7:
						tObj = load("res://Scenes/Support Scenes/square_grass_blue.tscn")
					elif x > 8 and y < 7:
						tObj = load("res://Scenes/Support Scenes/square_grass_green.tscn")
					elif x < 9 and y > 6:
						tObj = load("res://Scenes/Support Scenes/square_grass_yellow.tscn")
					else:
						tObj = load("res://Scenes/Support Scenes/square_grass_red.tscn")

					object = GDSync.multiplayer_instantiate(tObj, get_tree().get_root().get_node("Spatial/Board"), true, [], false)
				5:
					if x < 9 and y < 7:
						tObj = load("res://Scenes/Support Scenes/octagon_grass_blue.tscn")
					elif x > 8 and y < 7:
						tObj = load("res://Scenes/Support Scenes/octagon_grass_green.tscn")
					elif x < 9 and y > 6:
						tObj = load("res://Scenes/Support Scenes/octagon_grass_yellow.tscn")
					else:
						tObj = load("res://Scenes/Support Scenes/octagon_grass_red.tscn")

					object = GDSync.multiplayer_instantiate(tObj, get_tree().get_root().get_node("Spatial/Board"), true, [], false)
					vPos.y = -0.005
					vScale.x = 1.01161
					vScale.z = 1.01161
				0:
					if x < 9 and y < 7:
						tObj = load("res://Scenes/Support Scenes/square_blue.tscn")
					elif x > 8 and y < 7:
						tObj = load("res://Scenes/Support Scenes/square_green.tscn")
					elif x < 9 and y > 6:
						tObj = load("res://Scenes/Support Scenes/square_yellow.tscn")
					else:
						tObj = load("res://Scenes/Support Scenes/square_red.tscn")

					object = GDSync.multiplayer_instantiate(tObj, get_tree().get_root().get_node("Spatial/Board"), true, [], false)
				_:
					if x < 9 and y < 7:
						tObj = load("res://Scenes/Support Scenes/octagon_plain_blue.tscn")
					elif x > 8 and y < 7:
						tObj = load("res://Scenes/Support Scenes/octagon_plain_green.tscn")
					elif x < 9 and y > 6:
						tObj = load("res://Scenes/Support Scenes/octagon_plain_yellow.tscn")
					else:
						tObj = load("res://Scenes/Support Scenes/octagon_plain_red.tscn")

					object = GDSync.multiplayer_instantiate(tObj, get_tree().get_root().get_node("Spatial/Board"), true, [], false)
					vScale.x = 1.01155
					vScale.z = 1.01155

			object.position = vPos
			object.scale = vScale * 0.975
			object.visible = true
			node.tBoardModel[x][y] = object.name

func placeStartup():
	var node = get_tree().get_root().get_node("Spatial")
	var node1 = get_tree().get_root().get_node("Spatial/CanvasLayer/UI/InGame")

	if node.iCurPlay == Globals.iMyPN:
		Globals.tAvailableMods.clear()
		Globals.tAvailableMods.append({"I": 0, "F": "Dummy.tscn", "F2": "Dummy", "N": "Dummy", "CO": 0, "CA": 0, "EP": 0, "ER": 0, "OU": 0, "ST": 0, "ON": "N", "SI": "N"})
		var id = (Globals.iMyPN * 30) - 29

		for x in node.tMods:
			if x.id == id:
				var file = "res://Scenes/Support Scenes/" + x.model
				var file2 = "res://Assets/Textures/Models/" + x.model.trim_suffix(".tscn")
				Globals.tAvailableMods.append({"I": id, "F": file, "F2": file2, "N": x.name, "CO": x.cost, "CA": x.cashprod, "EP": x.energyprod, "ER": x.energyreq, "OU": x.output, "ST": x.storage, "ON": "N", "SI": "N"})
				Globals.iModules = 1

		node1.updateButtons()
		sTxt = "[PLACE STARTUP][br]It's your turn! Click on the Startup module and drag it onto the board."
		await(node1.updateGUI(sTxt, [], 0))
	else:
		otherPlayer("[PLACE STARTUP][br]")

func startUpPlaced(res):
	var node = get_tree().get_root().get_node("Spatial")
	# {"bOn": false, "x": 0, "y": 0}
	Globals.bDrag = false
	var node1 = get_tree().get_root().get_node("Spatial/CanvasLayer/UI/InGame")

	if res.bOn < 2:
		node1.resetDrag()
		sTxt = "[PLACE STARTUP][br]You have not placed the StartUp Module on a valid Board Location! Please try again."
		await(node1.updateGUI(sTxt, [], 0))
	else:
		var bOK = false

		if res.x < 9 and res.y < 7:
			if node.tAvailArea[1]:
				updateAvailArea(1)
				GDSync.call_func(updateAvailArea, [1])
				bOK = true
		elif res.x > 8 and res.y > 6:
			if node.tAvailArea[4]:
				updateAvailArea(4)
				GDSync.call_func(updateAvailArea, [4])
				bOK = true
		elif res.x < 9 and res.y > 6:
			if node.tAvailArea[3]:
				updateAvailArea(3)
				GDSync.call_func(updateAvailArea, [3])
				bOK = true
		else:
			if node.tAvailArea[2]:
				updateAvailArea(2)
				GDSync.call_func(updateAvailArea, [2])
				bOK = true

		if not bOK:
			Globals.iButtons = 1
			node1.resetDrag()
			sTxt = "[PLACE STARTUP][br]That area of the board is already taken! Please try again."
			await(node1.updateGUI(sTxt, [], 0))
		else:
			var vTmpPos = Vector3(0.0, 1.0, 0.0)
			vTmpPos.x = node.tBoardLoc[res.x][res.y][0]
			vTmpPos.z = node.tBoardLoc[res.x][res.y][1]
			Globals.dragObject.set_position(vTmpPos)
			Globals.iPlacedX = res.x
			Globals.iPlacedY = res.y
			Globals.bDrag = false
			sTxt = "[PLACE STARTUP][br]Congratulations! You have successfully placed the StartUp Module.[br]Press OK to continue or RESET to undo."
			await(node1.updateGUI(sTxt, [], 4))

func construction():
	var node = get_tree().get_root().get_node("Spatial")
	var sT = Messages.Msg2Txt(Globals.iWait)
	node.myDebug({"iWait": sT})
	# ID = 36, 46, 56, 66 | Blue, Green, Red, Yellow
	var node1 = get_tree().get_root().get_node("Spatial/CanvasLayer/UI/InGame")
	sTxtSpeech = ""

	if node.iCurPlay == Globals.iMyPN:
		if node.tConstruction[node.iCurPlay]:
			var iMax = 0
			var iTmp1 = 30 * node.iCurPlay - 30
			var iTmp2 = 30 * node.iCurPlay

			for x in range(1, 17):
				for y in range(1, 13):
					if node.tBuildings[x][y] > iTmp1 and node.tBuildings[x][y] < iTmp2:
						var iTmp = floor(node.tModules[x][y].cost / 2.0)

						if iTmp > iMax:
							iMax = iTmp

			if iMax <= node.tBank[node.iCurPlay]:
				sTxt = "[CONSTRUCTION][br]It's your turn! Since you have a Construction module and sufficient funds, you can move ONE of your modules currently on the map.[br]Press DONE to finish your turn."
				await(node1.updateGUI(sTxt, [], 6))
				Globals.iWait = Messages.Msg.WAIT_MOVE_MODULES
			else:
				sTxt = "[CONSTRUCTION][br]It's your turn! You do have a Construction module but, unfortunately, insufficient funds to move your most expensive module.[br]Press OK to continue."
				await(node1.updateGUI(sTxt))
		else:
			sTxt = "[CONSTRUCTION][br]It's your turn! Unfortunately, you do not have a Construction module.[br]Press OK to continue."
			await(node1.updateGUI(sTxt))
	else:
		otherPlayer("[CONSTRUCTION][br]")

func placeModules(bIn):
	var node = get_tree().get_root().get_node("Spatial")
	var sT = Messages.Msg2Txt(Globals.iWait)
	node.myDebug({"iWait": sT})
	var node1 = get_tree().get_root().get_node("Spatial/CanvasLayer/UI/InGame")
	sTxtSpeech = ""

	if node.iCurPlay == Globals.iMyPN:
		var bFunds = populateAvailableMods()

		if bIn:
			if Globals.tAvailableMods.size() > 4:
				Globals.iModules = 3
			else:
				Globals.iModules = Globals.tAvailableMods.size() - 1

		if bFunds:
			if Globals.iModules > 0:
				if Globals.tAvailableMods[1].I == (node.iCurPlay * 30) - 10:
					Globals.iWait = Messages.Msg.WAIT_PLACE_HABITATION
					sTxt = "[PLACE MODULES][br]You have to place a Habitation module before placing any more modules.[br]Press OK when you have placed your habitation module, press RESET to undo, and (or) press DONE to finish your turn."
					await(node1.updateButtons())
					await(node1.updateGUI(sTxt, [], 5))
				else:
					var bOK = true

					if node.tNumModules[Globals.iMyPN] > 12:
						bOK = false
						var tNum = 30 * node.iCurPlay

						for x in range(1, 17):
							for y in range(1, 13):
								if node.tBuildings[x][y] == tNum - 10:
									if node.tModules[x][y].online == "Y":
										bOK = true

					if bOK:
						Globals.iWait = Messages.Msg.WAIT_PLACE_MORE_MODULES

						if Globals.iModules > 1:
							sTxt = "[PLACE MODULES][br]You can place up to " + str(Globals.iModules) + " modules."
						else:
							sTxt = "[PLACE MODULES][br]You can place one module."

						sTxtSpeech = sTxt + "[br]Press OK when you have placed your module, press RESET to undo, and, or, press DONE to finish your turn."
						sTxt += "[br]Press OK when you have placed your module, press RESET to undo, and (or) press DONE to finish your turn."

						await(node1.updateButtons())
						await(node1.updateGUI(sTxt, [], 5, sTxtSpeech))
					else:
						sTxt = "[PLACE MODULES][br]You cannot place any modules as your Habitation Module is Offline![br]Press OK to continue."
						await(node1.updateGUI(sTxt))
						Globals.iWait = Messages.Msg.WAIT_NO_MODULES
			else:
				sTxt = "[PLACE MODULES][br]You do not have any modules you can place![br]Press OK to continue."
				await(node1.updateGUI(sTxt))
				Globals.iWait = Messages.Msg.WAIT_NO_MODULES
		else:
			sTxt = "[PLACE MODULES][br]You do not have enough money to place a module![br]Press OK to continue."
			await(node1.updateGUI(sTxt))
			Globals.iWait = Messages.Msg.WAIT_NO_MODULES
	else:
		otherPlayer("[PLACE MODULES][br]")

func modulePlaced(result, bPlaced):
	var node = get_tree().get_root().get_node("Spatial")
	var sT = Messages.Msg2Txt(Globals.iWait)
	node.myDebug({"iWait": sT, "result": result, "bPlaced": bPlaced})
	var node1 = get_tree().get_root().get_node("Spatial/CanvasLayer/UI/InGame")
	var vTmpPos = Vector3(0.0, 1.0, 0.0)
	vTmpPos.x = node.tBoardLoc[result.x][result.y][0]
	vTmpPos.z = node.tBoardLoc[result.x][result.y][1]
	Globals.dragObject.set_position(vTmpPos)
	Globals.iPlacedX = result.x
	Globals.iPlacedY = result.y
	Globals.bDrag = false
	var bOK = false
	var iMin = 0
	var iMax = 0
	var tNum = 30 * Globals.iMyPN

	if result.bOn == 2:
		var bSquare = false
		var xx = result.x
		var yy = result.y
		result = null

		if xx / 2.0 == floor(xx / 2.0):
			if yy / 2.0 != floor(yy / 2.0):
				bSquare = true
		else:
			if yy / 2.0 == floor(yy / 2.0):
				bSquare = true

		iMin = tNum - 29
		iMax = tNum - 6

		if bSquare:
			bOK = chkSquare(iMin, iMax, xx, yy)
		else:
			bOK = chkOctagon(iMin, iMax, xx, yy)

		if not bOK:
			if bPlaced:
				sTxt = "[PLACE MODULES][br]The module has not been placed next to another one of your modules![br]Please try again, or press DONE to finish your turn."
			else:
				sTxt = "[CONSTRUCTION][br]The module has not been moved next to another one of your modules![br]Please try again, or press DONE to finish your turn."

			node1.resetDrag()
			await(node1.updateGUI(sTxt, [], 6))
		else:
			if Globals.iCurModDND >= tNum - 21 and Globals.iCurModDND <= tNum - 12:
				iMin = tNum - 11
				iMax = iMin

				if bSquare:
					bOK = chkSquare(iMin, iMax, xx, yy)
				else:
					bOK = chkOctagon(iMin, iMax, xx, yy)

				if not bOK:
					iMin = tNum - 22
					iMax = iMin

					if bSquare:
						bOK = chkSquare(iMin, iMax, xx, yy)
					else:
						bOK = chkOctagon(iMin, iMax, xx, yy)

					if bOK:
						iMin = tNum - 11
						iMax = iMin

						if bSquare:
							bOK = chkSquare(iMin, iMax, xx, yy)
						else:
							bOK = chkOctagon(iMin, iMax, xx, yy)

						if not bOK:
							var sMod = ""

							if Globals.iCurModDND == tNum - 13:
								sMod = "Barn"
							elif Globals.iCurModDND == tNum - 12:
								sMod = "Megabarn"
							elif Globals.iCurModDND == tNum - 21:
								sMod = "Beef"
							elif Globals.iCurModDND == tNum - 20:
								sMod = "Butter"
							elif Globals.iCurModDND == tNum - 19:
								sMod = "Cheese"
							elif Globals.iCurModDND == tNum - 18:
								sMod = "Cream"
							elif Globals.iCurModDND == tNum - 17:
								sMod = "Ice Cream"
							elif Globals.iCurModDND == tNum - 16:
								sMod = "Leather"
							elif Globals.iCurModDND == tNum - 15:
								sMod = "Manure"
							elif Globals.iCurModDND == tNum - 14:
								sMod = "Milk"

							if bPlaced:
								sTxt = "[PLACE MODULES][br]The " + sMod + " Store has not been placed next to a Processing Plant, or next to a Hub next to a Processing Plant![br]Please try again, or press DONE to finish your turn."
							else:
								sTxt = "[CONSTRUCTION][br]The " + sMod + " Store has not been moved next to a Processing Plant, or next to a Hub next to a Processing Plant![br]Please try again, or press DONE to finish your turn."

							node1.resetDrag()
							await(node1.updateGUI(sTxt, [], 6))
			elif Globals.iCurModDND == tNum - 7:
				iMax = tNum - 12
				iMin = iMax - 1

				if bSquare:
					bOK = chkSquare(iMin, iMax, xx, yy)
				else:
					bOK = chkOctagon(iMin, iMax, xx, yy)

				if not bOK:
					iMin = tNum - 22
					iMax = iMin

					if bSquare:
						bOK = chkSquare(iMin, iMax, xx, yy)
					else:
						bOK = chkOctagon(iMin, iMax, xx, yy)

					if bOK:
						iMax = tNum - 12
						iMin = iMax - 1

						if bSquare:
							bOK = chkSquare(iMin, iMax, xx, yy)
						else:
							bOK = chkOctagon(iMin, iMax, xx, yy)

						if not bOK:
							if bPlaced:
								sTxt = "[PLACE MODULES][br]The Pasture Dome has not been placed next to a Barn or MegaBarn, or next to a Hub next to a Barn or MegaBarn![br]Please try again, or press DONE to finish your turn."
							else:
								sTxt = "[CONSTRUCTION][br]The Pasture Dome has not been moved next to a Barn or MegaBarn, or next to a Hub next to a Barn or MegaBarn![br]Please try again, or press DONE to finish your turn."

							node1.resetDrag()
							await(node1.updateGUI(sTxt, [], 6))
			elif Globals.iCurModDND == tNum - 27:
				if node.tBoard[xx][yy] == 2 or node.tBoard[xx][yy] == 3:
					bOK = true
				else:
					bOK = false

				if not bOK:
					if bPlaced:
						sTxt = "[PLACE MODULES][br]The Geothermal Powerplant has not been placed on a Fault Line![br]Please try again, or press DONE to finish your turn."
					else:
						sTxt = "[CONSTRUCTION][br]The Geothermal Powerplant has not been moved to a Fault Line![br]Please try again, or press DONE to finish your turn."

					node1.resetDrag()
					await(node1.updateGUI(sTxt, [], 6))

	if bOK:
		if Globals.iWait == Messages.Msg.WAIT_MOVE_MODULES:
			if Globals.iConX == Globals.iPlacedX and Globals.iConY == Globals.iPlacedY:
				node1.resetDrag()
				sTxt = "[PLACE MODULES][br]The module has not been moved![br]Please try again, or press DONE to finish your turn."
				await(node1.updateGUI(sTxt, [], 7))
				Globals.bModuleMoved = false
			else:
				Globals.bDrag = false
				Globals.iWait = Messages.Msg.WAIT_MOVE_MODULE
				var iCostMove = floor(node.tModules[Globals.iConX][Globals.iConY].cost / 2.0)
				sTxt = "[CONSTRUCTION][br]The module has been moved at a cost of $" + iCostMove + "![br]Press OK to continue, RESET to undo, or DONE to finish your turn."
				Globals.bModuleMoved = true
				await(node1.updateGUI(sTxt, [], 5))
		else:
			if Globals.iModules == 1:
				Globals.bDrag = false
				node1.btnC2Done.visible = true
				node1.btnC2Done.disabled = false
				node1.disableBtnCon(true, 0)
				node1.clearBtnCon()
				sTxt = "[PLACE MODULES][br]Congratulations! You have successfully placed your last module.[br]Press RESET to undo, or DONE to finish your turn."
				await(node1.updateGUI(sTxt, [], 7))
			else:
				if bOK:
					Globals.bDrag = false
					sTxt = "[PLACE MODULES][br]Congratulations! You have successfully placed the module.[br]Press OK to continue, RESET to undo, or DONE to finish your turn."
					await(node1.updateGUI(sTxt, [], 5))
				else:
					sTxt = "[PLACE MODULES][br]You have insufficient funds to place more modules![br]Press OK to continue."
					await(node1.updateGUI(sTxt, [], 1))
					Globals.iWait = Messages.Msg.WAIT_NO_MODULES

func disease():
	var node = get_tree().get_root().get_node("Spatial")
	var sT = Messages.Msg2Txt(Globals.iWait)
	node.myDebug({"iWait": sT})
	var node1 = get_tree().get_root().get_node("Spatial/CanvasLayer/UI/InGame")

	if node.iCurPlay == Globals.iMyPN:
		if node.tNumDisease[node.iCurPlay] == 4:
			sTxt = "[DISEASE][br]It's your turn! Since you already have 4 diseased barns, you don't have to roll the dice.[br]Press OK to continue."
			await(node1.updateGUI(sTxt))
			Globals.iWait = Messages.Msg.WAIT_NO_DISEASE
		else:
			var bBarn = false
			var tNum = 30 * node.iCurPlay

			for x in range(1, 17):
				for y in range(1, 13):
					if node.tBuildings[x][y] == tNum - 13 or node.tBuildings[x][y] == tNum - 12:
						bBarn = true
						break

			if not bBarn:
				sTxt = "[DISEASE][br]It's your turn! Since you don't have any barns or megabarns, you don't have to roll the dice.[br]Press OK to continue."
				await(node1.updateGUI(sTxt))
				Globals.iWait = Messages.Msg.WAIT_NO_DISEASE
			else:
				sTxt = "[DISEASE][br]It's your turn! You must now roll a dice. Press OK to roll."
				await(node1.updateGUI(sTxt))
				Globals.iWait = Messages.Msg.DICE_DISEASE
	else:
		otherPlayer("[DISEASE][br]")
		Globals.iWait = Messages.Msg.WAIT_NO_DISEASE

func energy():
	var node = get_tree().get_root().get_node("Spatial")
	var sT = Messages.Msg2Txt(Globals.iWait)
	node.myDebug({"iWait": sT})
	var node1 = get_tree().get_root().get_node("Spatial/CanvasLayer/UI/InGame")

	if node.iCurPlay == Globals.iMyPN:
		var res = calculateEnergy()
		sTxt = "[ENERGY] It's your turn. You have produced " + str(res.P) + " and need " + str(res.R) + ", which results in a"

		if res.D < 0:
			sTxt += " DEFICIT of " + str(res.D) + "! So, you will have to take at least 1 module offline.[br]Select the module(s) to take offline and then press DONE to finish your turn."
			sTxtSpeech = sTxt + " DEFICIT of " + str(res.D) + "! So, you will have to take at least 1 module offline.[br]Select the module, or modules, to take offline, and then press DONE to finish your turn."
			await(node1.updateGUI(sTxt, [], 6, sTxtSpeech))
			Globals.iWait = Messages.Msg.WAIT_ENERGY_DEFICIT
		else:
			sTxt += " SURPLUS of " + str(res.D) + "."

			if res.S < 1000 and res.S <= res.D:
				sTxt += " You also have at least one module offline that can be brought back online.[br]Would you like to do this?"
				await(node1.updateGUI(sTxt, [], 2))
				Globals.iWait = Messages.Msg.WAIT_ENERGY_YN
			else:
				sTxt += "[br]Press OK to continue."
				await(node1.updateGUI(sTxt))
	else:
		otherPlayer("[ENERGY][br]")

func calculateEnergy():
	var node = get_tree().get_root().get_node("Spatial")
	var sT = Messages.Msg2Txt(Globals.iWait)
	node.myDebug({"iWait": sT})
	var energyProduced = 0
	var energyRequired = 0
	var energySmallest = 1000
	var tNum = 30 * node.iCurPlay

	for x in range(1, 17):
		for y in range(1, 13):
			if node.tBuildings[x][y] >= tNum - 29 and node.tBuildings[x][y] <= tNum - 6:
				if node.tModules[x][y].online == "Y":
					energyProduced += node.tModules[x][y].energyprod
					energyRequired += node.tModules[x][y].energyreq
				else:
					if node.tModules[x][y].energyreq < energySmallest:
						energySmallest = node.tModules[x][y].energyreq

	var energyDiff = energyProduced - energyRequired
	return {"P": energyProduced, "R": energyRequired, "D": energyDiff, "S": energySmallest}

func production():
	var node = get_tree().get_root().get_node("Spatial")
	var sT = Messages.Msg2Txt(Globals.iWait)
	node.myDebug({"iWait": sT})
	var node1 = get_tree().get_root().get_node("Spatial/CanvasLayer/UI/InGame")

	if node.iCurPlay == Globals.iMyPN:
		calculateProduction()
		node1.btnC21.set_text("BEEF: " + str(node.tStorage[node.iCurPlay].beef))
		node1.btnC22.set_text("BUTTER: " + str(node.tStorage[node.iCurPlay].butter))
		node1.btnC23.set_text("CHEESE: " + str(node.tStorage[node.iCurPlay].cheese))
		node1.btnC24.set_text("CREAM: " + str(node.tStorage[node.iCurPlay].cream))
		node1.btnC25.set_text("ICECREAM: " + str(node.tStorage[node.iCurPlay].icecream))
		node1.btnC26.set_text("LEATHER: " + str(node.tStorage[node.iCurPlay].leather))
		node1.btnC27.set_text("MANURE: " + str(node.tStorage[node.iCurPlay].manure))
		node1.btnC28.set_text("MILK: " + str(node.tStorage[node.iCurPlay].milk))
		node1.btnC21.disabled = true
		node1.btnC22.disabled = true
		node1.btnC23.disabled = true
		node1.btnC24.disabled = true
		node1.btnC25.disabled = true
		node1.btnC26.disabled = true
		node1.btnC27.disabled = true
		node1.btnC28.disabled = true
		var tNum = node.iCurPlay * 30

		for x in range(1, 17):
			for y in range(1, 13):
				if node.tBuildings[x][y] == tNum - 21:
					# ENABLE BEEF
					if node.tModules[x][y].online == "N":
						node1.btnC21.disabled = false
				elif node.tBuildings[x][y] == tNum - 20:
					# ENABLE BUTTER
					if node.tModules[x][y].online == "N":
						node1.btnC22.disabled = false
				elif node.tBuildings[x][y] == tNum - 19:
					# ENABLE CHEESE
					if node.tModules[x][y].online == "N":
						node1.btnC23.disabled = false
				elif node.tBuildings[x][y] == tNum - 18:
					# ENABLE CREAM
					if node.tModules[x][y].online == "N":
						node1.btnC24.disabled = false
				elif node.tBuildings[x][y] == tNum - 17:
					# ENABLE ICECREAM
					if node.tModules[x][y].online == "N":
						node1.btnC25.disabled = false
				elif node.tBuildings[x][y] == tNum - 16:
					# ENABLE LEATHER
					if node.tModules[x][y].online == "N":
						node1.btnC26.disabled = false
				elif node.tBuildings[x][y] == tNum - 15:
					# ENABLE MANURE
					if node.tModules[x][y].online == "N":
						node1.btnC27.disabled = false
				elif node.tBuildings[x][y] == tNum - 14:
					# ENABLE MILK
					if node.tModules[x][y].online == "N":
						node1.btnC28.disabled = false

		sTxt = "[PRODUCTION][br]You produced " + str(Globals.iProduction) + " commodities! Allocate your production.[br]Press RESET to reset and press DONE to finish your turn."
		await(node1.updateGUI(sTxt, [], 7))
	else:
		otherPlayer("[PRODUCTION][br]")

func calculateProduction():
	var node = get_tree().get_root().get_node("Spatial")
	var sT = Messages.Msg2Txt(Globals.iWait)
	node.myDebug({"iWait": sT})
	var prod = 0
	var iMin = -1
	var iMax = -1
	var bSquare = false
	var bOK = false
	var tNum = 30 * node.iCurPlay

	for x in range(1, 17):
		for y in range(1, 13):
			if node.tBuildings[x][y] == tNum - 13 or node.tBuildings[x][y] == tNum - 12:
				if node.tModules[x][y].online == "Y" and node.tModules[x][y].sick == "N":
					iMin = tNum - 11
					iMax = iMin

					if x / 2.0 == floor(x / 2.0):
						if y / 2.0 != floor(y / 2.0):
							bSquare = true
					else:
						if y / 2.0 == floor(y / 2.0):
							bSquare = true

					if bSquare:
						bOK = chkSquare(iMin, iMax, x, y)
					else:
						bOK = chkOctagon(iMin, iMax, x, y)

					if not bOK:
						iMin = tNum - 22
						iMax = iMin

						if bSquare:
							bOK = chkSquare(iMin, iMax, x, y)
						else:
							bOK = chkOctagon(iMin, iMax, x, y)

						if bOK:
							iMin = tNum - 11
							iMax = iMin

							if bSquare:
								bOK = chkSquare(iMin, iMax, x, y)
							else:
								bOK = chkOctagon(iMin, iMax, x, y)

							if bOK:
								prod += node.tModules[x][y].output
					else:
						prod += node.tModules[x][y].output

					if node.tBoard[x][y] == 4 or node.tBoard[x][y] == 5:
						if node.tBuildings[x][y] == tNum - 13:
							prod += 1
						elif node.tBuildings[x][y] == tNum - 12:
							prod += 2

	Globals.iProduction = prod

func randomEvent():
	var node = get_tree().get_root().get_node("Spatial")
	var sT = Messages.Msg2Txt(Globals.iWait)
	node.myDebug({"iWait": sT})
	var node1 = get_tree().get_root().get_node("Spatial/CanvasLayer/UI/InGame")

	if node.iCurPlay == Globals.iMyPN:
		var tTmp = ["Dice 1", "Dice 2"]
		node1.btnC2Yes.disabled = true
		Globals.iWait = Messages.Msg.DICE_RANDOM_EVENT
		sTxt = "[RANDOM EVENT][br]It's Random Event Time![br]Press each Dice Button below to roll your Dice. Good Luck!"
		await(node1.updateGUI(sTxt, tTmp, 3))
	else:
		otherPlayer("[RANDOM EVENT][br]")

func giftBoxes():
	var node = get_tree().get_root().get_node("Spatial")
	var sT = Messages.Msg2Txt(Globals.iWait)
	node.myDebug({"iWait": sT})
	var bPortal = false
	var bCatalog = false
	var bPortalOnline = false
	var bCatalogOnline = false
	var node1 = get_tree().get_root().get_node("Spatial/CanvasLayer/UI/InGame")

	if node.iCurPlay == Globals.iMyPN:
		if Globals.tREOther[Globals.iMyPN].nocatalog:
			bCatalog = true
			bCatalogOnline = true

		if node.tPortal[node.iCurPlay]:
			bPortal = true

			if bCatalog or node.tCatalog[node.iCurPlay]:
				bCatalog = true
				var tNum = 30 * node.iCurPlay

				for x in range(1, 17):
					for y in range(1, 13):
						if node.tBuildings[x][y] == tNum - 25:
							if node.tModules[x][y].online == "Y":
								bPortalOnline = true
						elif not bCatalogOnline:
							if node.tBuildings[x][y] == tNum - 26:
								if node.tModules[x][y].online == "Y":
									bCatalogOnline = true

		if bPortal:
			if bPortalOnline:
				if bCatalog:
					if bCatalogOnline:
						if node.tStorage[Globals.iMyPN].beef > 0:
							if node.tStorage[Globals.iMyPN].cheese > 0:
								var iGift = min(node.tStorage[Globals.iMyPN].beef, node.tStorage[Globals.iMyPN].cheese)
								sTxt = "[GIFT BOXES][br]Congratulations! You can sell up to " + str(iGift) + " Gift Boxes at $" + str(Globals.tREOther[Globals.iMyPN].giftboxes) + " each! Click on a button to select the number to sell, then press DONE to finish your turn."
								var btns = []

								if iGift >= 1:
									btns = ["ONE"]

								if iGift >= 2:
									btns.append("TWO")

								if iGift >= 3:
									btns.append("THREE")

								if iGift >= 4:
									btns = ["FOUR"]

								if iGift >= 5:
									btns.append("FIVE")

								if iGift >= 6:
									btns.append("SIX")

								if iGift >= 7:
									btns = ["SEVEN"]

								if iGift >= 8:
									btns.append("EIGHT")

								if iGift >= 9:
									btns.append("NINE")

								if iGift == 10:
									btns.append("TEN")

								await(node1.updateGUI(sTxt, btns, 6))
								Globals.iWait = Messages.Msg.SELL_GIFT_BOXES
							else:
								sTxt = "[GIFT BOXES][br]You cannot sell any Gift Boxes as you do not have any stored Cheese![br]Press OK to continue."
								await(node1.updateGUI(sTxt))
								Globals.iWait = Messages.Msg.NO_GIFT_BOXES
						else:
							sTxt = "[GIFT BOXES][br]You cannot sell any Gift Boxes as you do not have any stored Beef![br]Press OK to continue."
							await(node1.updateGUI(sTxt))
							Globals.iWait = Messages.Msg.NO_GIFT_BOXES
					else:
						sTxt = "[GIFT BOXES][br]You cannot sell any Gift Boxes as your Catalog Store is offline![br]Press OK to continue."
						await(node1.updateGUI(sTxt))
						Globals.iWait = Messages.Msg.NO_GIFT_BOXES
				else:
					sTxt = "[GIFT BOXES][br]You cannot sell any Gift Boxes as you do not have a Catalog Store![br]Press OK to continue."
					await(node1.updateGUI(sTxt))
					Globals.iWait = Messages.Msg.NO_GIFT_BOXES
			else:
				sTxt = "[GIFT BOXES][br]You cannot sell any Gift Boxes as your Portal is offline![br]Press OK to continue."
				await(node1.updateGUI(sTxt))
				Globals.iWait = Messages.Msg.NO_GIFT_BOXES
		else:
			sTxt = "[GIFT BOXES][br]You cannot sell any Gift Boxes as you do not have a Portal![br]Press OK to continue."
			await(node1.updateGUI(sTxt))
			Globals.iWait = Messages.Msg.NO_GIFT_BOXES
	else:
		otherPlayer("[GIFT BOXES][br]")

func setCommodityPrices():
	var node = get_tree().get_root().get_node("Spatial")
	var sT = Messages.Msg2Txt(Globals.iWait)
	node.myDebug({"iWait": sT})

	for x in range(8):
		var p = randi() % 6 + 1
		updatePrices(x, p)
		GDSync.call_func(updatePrices, [x, p])

func commodityPrices():
	var node = get_tree().get_root().get_node("Spatial")
	var sT = Messages.Msg2Txt(Globals.iWait)
	node.myDebug({"iWait": sT})
	var node1 = get_tree().get_root().get_node("Spatial/CanvasLayer/UI/InGame")
	var tT = ["", "", "", "", "", "", "", ""]
	sTxtSpeech = ""
	Globals.iSales = 0
	Globals.iPrice = 0

	if Globals.tREOther[node.iCurPlay].reroll:
		for x in range(8):
			if node.tPrices[x] == 1:
				node.tPrices[x] = randi() % 6 + 1

	var iP = node.tPrices[0] + node.tREPrices[node.iCurPlay].beef
	tT[0] = "BEEF: $" + str(iP)
	iP = node.tPrices[1] + node.tREPrices[node.iCurPlay].butter
	tT[1] = "BUTTER: $" + str(iP)
	iP = node.tPrices[2] + node.tREPrices[node.iCurPlay].cheese
	tT[2] = "CHEESE: $" + str(iP)
	iP = node.tPrices[3] + node.tREPrices[node.iCurPlay].cream
	tT[3] = "CREAM: $" + str(iP)
	iP = node.tPrices[4] + node.tREPrices[node.iCurPlay].icecream
	tT[4] = "ICECREAM: $" + str(iP)
	iP = node.tPrices[5] + node.tREPrices[node.iCurPlay].leather
	tT[5] = "LEATHER: $" + str(iP)
	iP = node.tPrices[6] + node.tREPrices[node.iCurPlay].manure
	tT[6] = "MANURE: $" + str(iP)
	iP = node.tPrices[7] + node.tREPrices[node.iCurPlay].milk
	tT[7] = "MILK: $" + str(iP)

	if node.iCurPlay == Globals.iMyPN:
		sTxt = "[COMMODITY PRICES][br]Your Commodity Prices for this turn are shown below: "
		sTxtSpeech = sTxt + "[br]"

		for x in range (1, 9):
			node1.tCButtons[x].disabled = true

		for x in tT:
			sTxt += x + ", "
			sTxtSpeech += x + "[br]"

		var bPortal = false
		var bPortalOnline = false

		if node.tPortal[node.iCurPlay]:
			bPortal = true
			var tNum = 30 * node.iCurPlay - 25

			for x in range(1, 17):
				for y in range(1, 13):
					if node.tBuildings[x][y] == tNum:
						if node.tModules[x][y].online == "Y":
							bPortalOnline = true
							break

		if bPortal:
			if bPortalOnline:
				sTxt += "You can now sell your commodities."
				Globals.iWait = Messages.Msg.SELL_COMMODITIES
				sTxt += "[br]Press DONE to finish your turn."
				await(node1.updateGUI(sTxt, tT, 6))
			else:
				sTxt += "Sorry, your Portal is not online, so you cannot sell any commodities!"
				sTxtSpeech = sTxt + "Sorry, your Portal is not online, so you cannot sell any commodities.\n"
				Globals.iWait = Messages.Msg.NO_COMMODITIES

				sTxt += "[br]Press OK to continue."
				sTxtSpeech += " Press OK to continue."
				await(node1.updateGUI(sTxt, tT, 1, sTxtSpeech))
		else:
			sTxt += "Sorry, you do not have a Portal, so you cannot sell any commodities!"
			sTxtSpeech = sTxt + "Sorry, you do not have a Portal, so you cannot sell any commodities."
			Globals.iWait = Messages.Msg.NO_COMMODITIES

			sTxt += "[br]Press OK to continue."
			await(node1.updateGUI(sTxt, tT, 1, sTxtSpeech))
	else:
		otherPlayer("[COMMODITY PRICES]")

func sellCommodity():
	var node = get_tree().get_root().get_node("Spatial")
	var sT = Messages.Msg2Txt(Globals.iWait)
	node.myDebug({"iWait": sT, "Globals.iCommodityCount": Globals.iCommodityCount})
	var node1 = get_tree().get_root().get_node("Spatial/CanvasLayer/UI/InGame")
	var iStore = 0
	var sCommodity = ""
	var tTmp = []
	tTmp.append("Dummy")

	match Globals.iCommodityCount:
		1:
			sCommodity = "BEEF"
			iStore = node.tStorage[Globals.iMyPN].beef + node.tREStorage[Globals.iMyPN].beef
			Globals.iPrice = node.tPrices[Globals.iMyPN].beef
		2:
			sCommodity = "BUTTER"
			iStore = node.tStorage[Globals.iMyPN].butter + node.tREStorage[Globals.iMyPN].butter
			Globals.iPrice = node.tPrices[Globals.iMyPN].butter
		3:
			sCommodity = "CHEESE"
			iStore = node.tStorage[Globals.iMyPN].cheese + node.tREStorage[Globals.iMyPN].cheese
			Globals.iPrice = node.tPrices[Globals.iMyPN].cheese
		4:
			sCommodity = "CREAM"
			iStore = node.tStorage[Globals.iMyPN].cream + node.tREStorage[Globals.iMyPN].cream
			Globals.iPrice = node.tPrices[Globals.iMyPN].cream
		5:
			sCommodity = "ICECREAM"
			iStore = node.tStorage[Globals.iMyPN].icecream + node.tREStorage[Globals.iMyPN].icecream
			Globals.iPrice = node.tPrices[Globals.iMyPN].icecream
		6:
			sCommodity = "LEATHER"
			iStore = node.tStorage[Globals.iMyPN].leather + node.tREStorage[Globals.iMyPN].leather
			Globals.iPrice = node.tPrices[Globals.iMyPN].leather
		7:
			sCommodity = "MANURE"
			iStore = node.tStorage[Globals.iMyPN].manure + node.tREStorage[Globals.iMyPN].manure
			Globals.iPrice = node.tPrices[Globals.iMyPN].manure
		8:
			sCommodity = "MILK"
			iStore = node.tStorage[Globals.iMyPN].milk + node.tREStorage[Globals.iMyPN].milk
			Globals.iPrice = node.tPrices[Globals.iMyPN].milk

	if iStore > 0:
		for x in range (1, iStore + 1):
			tTmp.append(node.tWords[x])

		sTxt = "[SELL COMMODITIES][br]Select the amount of " + sCommodity + " you wish to sell from the buttons below."
	else:
		tTmp.append("ZERO")
		sTxt = "[SELL COMMODITIES][br]Unfortunately, you do not have any " + sCommodity + " to sell.[br]Press the ZERO button below."

	await(node1.updateGUI(sTxt, tTmp, 3))
	Globals.iCommodityCount += 1

func lawOffice():
	var node = get_tree().get_root().get_node("Spatial")
	var sT = Messages.Msg2Txt(Globals.iWait)
	node.myDebug({"iWait": sT})
	var xx = 0
	var yy = 0
	var node1 = get_tree().get_root().get_node("Spatial/CanvasLayer/UI/InGame")

	if node.iCurPlay == Globals.iMyPN:
		if node.tLawOffice[Globals.iMyPN]:
			var tNum = Globals.iMyPN * 30 - 6

			for x in range(1, 17):
				for y in range(1, 13):
					if node.tBuildings[x][y] == tNum:
						xx = x
						yy = y
						break

			if node.tModules[xx][yy].online == "Y":
				var bOK = false
				var bFunds = true
				var tT = []

				if node.tBank[Globals.iMyPN] < 50:
					bFunds = false
				else:
					for x in range(1, 5):
						if x != Globals.iMyPN:
							if node.tBank[x] >= 50:
								bOK = true
								tT.append(node.tOOP[x].name)

				if bOK and bFunds:
					sTxt = "[LAW OFFICE][br]Congratulations! You are in a position to sue one of the following players: "

					for x in tT:
						sTxt += tT + ", "

					sTxt = sTxt[-2] + "![br]Select a player to sue, or press DONE to finish your turn."
					await(node1.updateGUI(sTxt, tT, 1))
					Globals.iWait = Messages.Msg.LAW_OFFICE_WHO
				elif not bOK:
					sTxt = "[LAW OFFICE][br]Unfortunately, none of the other players have enough money for you to sue them![br]Press OK to continue."
					Globals.iWait = Messages.Msg.NO_LAW_OFFICE
					await(node1.updateGUI(sTxt))
				elif not bFunds:
					sTxt = "[LAW OFFICE][br]Unfortunately, you do not have enough money to sue anyone![br]Press OK to continue."
					Globals.iWait = Messages.Msg.NO_LAW_OFFICE
					await(node1.updateGUI(sTxt))
			else:
				sTxt = "[LAW OFFICE][br]Unfortunately, your Law Office is offline![br]Press OK to continue."
				Globals.iWait = Messages.Msg.NO_LAW_OFFICE
				await(node1.updateGUI(sTxt))
		else:
			sTxt = "[LAW OFFICE][br]Unfortunately, you do not have a Law Office![br]Press OK to continue."
			Globals.iWait = Messages.Msg.NO_LAW_OFFICE
			await(node1.updateGUI(sTxt))
	else:
		otherPlayer("[LAW OFFICE][br]")

func sueDice():
	var node = get_tree().get_root().get_node("Spatial")
	var sT = Messages.Msg2Txt(Globals.iWait)
	node.myDebug({"iWait": sT})
	var node1 = get_tree().get_root().get_node("Spatial/CanvasLayer/UI/InGame")
	var iDice = randi() % 6 + 1
	var amt = 0

	if iDice <= 4:
		# Victory
		amt = 10 * iDice
		node.iBank[node.iCurPlay] += amt
		node.iBank[Globals.iSue] -= amt
		sTxt = "[LAW OFFICE][br]You rolled a " + str(iDice) + "! You won! " + node.tOOP[Globals.iSue].name + " pays you $" + str(amt) + " in reparations![br]Press OK to continue."
	elif iDice == 5:
		# Dismissed
		sTxt = "[LAW OFFICE][br]You rolled a 5! The case was dismissed![br]Press OK to continue."
	else:
		# Lost
		amt = -25
		node.iBank[node.iCurPlay] -= amt
		node.iBank[Globals.iSue] += amt
		sTxt = "[LAW OFFICE][br]You rolled a 6! You lost! You have paid " + node.tOOP[Globals.iSue].name + " $25 in fines![br]Press OK to continue."

	await(node1.updateGUI(sTxt))
	Globals.iWait = Messages.Msg.SUE_DICE_DONE
	var tIC = GDSync.get_all_clients()
	var iID = 0

	for x in tIC:
		if node.tOOP[Globals.iSue].name == GDSync.get_player_data(x.ID, "Username", "Unkown"):
			iID = x.ID
			break

	var tNot = []

	for x in tIC:
		if x.ID != iID and x.ID != node.iCurPlay:
			tNot.push_back(x.ID)

	var ID = GDSync.get_client_id()
	GDSync.call_func_on(iID, sueOutcome, [ID, iDice, amt])

	if tNot.size() > 0:
		for x in tNot:
			GDSync.call_func_on(x, sueOutcomeNot, [iID, ID, iDice, amt])

func sueOutcomeNot(iID, ID, iDice, amt):
	var node1 = get_tree().get_root().get_node("Spatial/CanvasLayer/UI/InGame")
	var name1 = GDSync.get_player_data(ID, "Username", "Unknown")
	var name2 = GDSync.get_player_data(iID, "Username", "Unknown")

	sTxt = "[LAW OFFICE][br]" + name1 + " has sued " + name2 + "!"

	if iDice <= 4:
		sTxt += " They rolled a " + str(iDice) + ", Which means they won and " + name2 + " had to pay them $" + str(amt) + " in reparations!"
	elif iDice == 5:
		sTxt += " They rolled a 5, which means the case was dismissed!"
	else:
		sTxt += " They rolled a 6, which means they lost and had to pay " + name2 + " $25 in reparations!"

	await(node1.updateGUI(sTxt, [], 0))

func sueOutcome(inPID, inD, inA):
	var node = get_tree().get_root().get_node("Spatial")
	var sT = Messages.Msg2Txt(Globals.iWait)
	node.myDebug({"iWait": sT})
	var node1 = get_tree().get_root().get_node("Spatial/CanvasLayer/UI/InGame")
	var name1 = GDSync.get_player_data(inPID, "Username", "Unkown")

	if inD <= 4:
		sTxt = "[LAW OFFICE][br]" + name1 + " has sued you![br]They rolled a " + str(inD) + ", which means they won and you have had to pay them $" + str(inA) + " in reparations!"
		await(node1.updateGUI(sTxt, [], 0))
	elif inD == 5:
		sTxt = "[LAW OFFICE][br]" + name1 + " tried to sue you![br]However, they rolled a 5, which means the case was dismissed!"
		await(node1.updateGUI(sTxt, [], 0))
	else:
		sTxt = "[LAW OFFICE][br]" + name1 + " tried to sue you![br]However, they rolled a 6, which means they lost and have had to pay you $25 in fines!"
		await(node1.updateGUI(sTxt, [], 0))

func veterinary():
	var node = get_tree().get_root().get_node("Spatial")
	var sT = Messages.Msg2Txt(Globals.iWait)
	node.myDebug({"iWait": sT})
	var bVetOnline = false
	var node1 = get_tree().get_root().get_node("Spatial/CanvasLayer/UI/InGame")

	if node.iCurPlay == Globals.iMyPN:
		Globals.iCount = node.tNumDisease[node.iCurPlay]
		node.tNumRolls[node.iCurPlay] = 1
		var tNum = 30 * node.iCurPlay - 23

		if Globals.iCount > 0:
			for x in range(1, 17):
				for y in range(1, 13):
					if node.tBuildings[x][y] == tNum:
						if node.tModules[x][y].online == "Y":
							bVetOnline = true
							break

			var tDice = []
			node.tBarns = []
			var tNum1 = 30 * node.iCurPlay - 13
			var tNum2 = 30 * node.iCurPlay - 12

			for x in range(1, 17):
				for y in range(1, 13):
					if node.tBuildings[x][y] == tNum1 and node.tModules[x][y].sick == "Y":
						tDice.append("Barn at " + str(x) + " : " + str(y))
						node.tBarns.append({"x": x, "y": y, "t": 0})
					elif node.tBuildings[x][y] == tNum2 and node.tModules[x][y].sick == "Y":
						tDice.append("MegaBarn at" + str(x) + " : " + str(y))
						node.tBarns.append({"x": x, "y": y, "t": 1})

			if bVetOnline:
				if Globals.iCount > 1:
					sTxt = "[VETERINARY][br]Since you have an online Veterinary module, you can roll 2 dice for each of your " + str(Globals.iCount) + " sick Barns or Megabarns![br]Press each button to roll the dice, then press DONE to finish your turn."
				else:
					sTxt = "[VETERINARY][br]Since you have an online Veterinary module, you can roll 2 dice for your sick Barn or Megabarn![br]Press the button to roll the dice, then press DONE to finish your turn."

				node.tNumRolls[node.iCurPlay] = 2
				await(node1.updateGUI(sTxt, tDice, 6))
				Globals.iWait = Messages.Msg.VETERINARY_DICE_TWO
			else:
				if Globals.iCount > 1:
					sTxt = "[VETERINARY][br]Since you do not have an online Veterinary module, you can roll 1 dice for each of your " + str(Globals.iCount) + " sick Barns or Megabarns![br]Press each button to roll the dice, then press DONE to finish your turn."
				else:
					sTxt = "[VETERINARY][br]Since you do not have an online Veterinary module, you can roll 1 dice for your sick Barn or Megabarn![br]Press the button to roll the dice, then press DONE to finish your turn."

				await(node1.updateGUI(sTxt, tDice, 6))
				Globals.iWait = Messages.Msg.VETERINARY_DICE_ONE
		else:
			sTxt = "[VETERINARY][br]You do not have any sick Barns or Megabarns![br]Press OK to continue."
			await(node1.updateGUI(sTxt))
			Globals.iWait = Messages.Msg.NO_VETERINARY
	else:
		otherPlayer("[VETERINARY][br]")

func veterinaryReroll():
	var node = get_tree().get_root().get_node("Spatial")
	var sT = Messages.Msg2Txt(Globals.iWait)
	node.myDebug({"iWait": sT})
	var node1 = get_tree().get_root().get_node("Spatial/CanvasLayer/UI/InGame")
	Globals.iCount = node.tNumDisease[node.iCurPlay]
	node.tNumRolls[node.iCurPlay] = 1

	if Globals.iCount > 0:
		var tDice = []
		node.tBarns = []
		var tNum1 = 30 * node.iCurPlay - 13
		var tNum2 = 30 * node.iCurPlay - 12

		for x in range(1, 17):
			for y in range(1, 13):
				if node.tBuildings[x][y] == tNum1 and node.tModules[x][y].sick == "Y":
					tDice.append("Barn at " + str(x) + " : " + str(y))
					node.tBarns.append({"x": x, "y": y, "t": 0})
				elif node.tBuildings[x][y] == tNum2 and node.tModules[x][y].sick == "Y":
					tDice.append("MegaBarn at" + str(x) + " : " + str(y))
					node.tBarns.append({"x": x, "y": y, "t": 0})
	
		if Globals.iCount > 1:
			sTxt = "[VETERINARY][br]You still have sick Barns or Megabarns, so you can now roll the second dice for each of your " + str(Globals.iCount) + " sick Barns or Megabarns![br]Press each button to roll the dice, then press DONE to finish your turn."
		else:
			sTxt = "[VETERINARY][br]You still have a sick Barn or Megabarn, so you can now roll the second dice![br]Press the button to roll the dice, then press DONE to finish your turn."

		node.tNumRolls[node.iCurPlay] = 2
		await(node1.updateGUI(sTxt, tDice, 1))
		Globals.iWait = Messages.Msg.VETERINARY_DICE_ONE
	else:
		sTxt = "[VETERINARY][br]You do not have any more sick Barns or Megabarns![br]Press OK to continue."
		await(node1.updateGUI(sTxt))
		Globals.iWait = Messages.Msg.NO_VETERINARY

func resetCommodities():
	var node = get_tree().get_root().get_node("Spatial")
	var sT = Messages.Msg2Txt(Globals.iWait)
	node.myDebug({"iWait": sT})
	var iMin = (30 * node.iCurPlay) - 21
	var iMax = iMin + 4
	var node1 = get_tree().get_root().get_node("Spatial/CanvasLayer/UI/InGame")

	if node.iCurPlay == Globals.iMyPN:
		if not Globals.tREOther[node.iCurPlay].keepunsold:
			for x in range(1, 17):
				for y in range(1, 13):
					if node.tBuildings[x][y] >= iMin and node.tBuildings[x][y] <= iMax:
						node.updateModules(x, y, 2, 0)
						GDSync.call_func(node.updateModules, [x, y, 2, "N"])
					elif node.tBuildings[x][y] == iMin + 7:
						node.updateModules(x, y, 2, 0)
						GDSync.call_func(node.updateModules, [x, y, 2, "N"])

			node.tStorage[node.iCurPlay].beef = 0
			node.tStorage[node.iCurPlay].butter = 0
			node.tStorage[node.iCurPlay].cheese = 0
			node.tStorage[node.iCurPlay].cream = 0
			node.tStorage[node.iCurPlay].icecream = 0
			node.tStorage[node.iCurPlay].milk = 0
			sTxt = "[RESET COMMODITIES][br]Your commodities, except for Leather and Manure, have been reset to zero![br]Press OK to continue."
			await(node1.updateGUI(sTxt))
			Globals.iWait = Messages.Msg.WAIT_RESET
		else:
			sTxt = "[RESET COMMODITIES][br]Your comnmodities have not been reset to zero in line with your Random Event outcome![br]Press OK to continue."
			await(node1.updateGUI(sTxt))
			Globals.iWait = Messages.Msg.WAIT_RESET
	else:
		otherPlayer("[RESET COMMODITIES][br]")

func endOfRound():
	var node = get_tree().get_root().get_node("Spatial")
	var sT = Messages.Msg2Txt(Globals.iWait)
	node.myDebug({"iWait": sT})
	node.iRound += 1
	var node1 = get_tree().get_root().get_node("Spatial/CanvasLayer/UI/InGame")
	sTxt = "[END OF ROUND][br]That's the end of Round " + str(node.iRound) + "! There are " + str(node.iMaxRounds - node.iRound) + " rounds remaining.[br]Press OK to continue."
	await(node1.updateGUI(sTxt))

func updateVote(inVote):
	var node = get_tree().get_root().get_node("Spatial")
	var sT = Messages.Msg2Txt(Globals.iWait)
	node.myDebug({"iWait": sT})
	node.tPlayOn[Globals.iMyPN] = inVote

func tiedGame(iIn):
	# It's a TIE! Play on?
	#	If Yes, need to see if players would like 3 more rounds? (100% acceptance)
	# 		If Yes, iMaxRounds += 3
	#		If No, GAME OVER
	#	If No, GAME OVER
	var node = get_tree().get_root().get_node("Spatial")
	var tT = []
	var iC = 0

	for x in node.tPlayOn:
		if iC == 0:
			iC += 1
		else:
			iC += 1

			if x == 0:
				tT.append(iC)

	var p1 = node.tOOP[tT[0]].name
	var p2 = node.tOOP[tT[1]].name
	sTxt = "[TIED GAME][br]That's the end of the final Round and the game has ended in a TIE between "

	if iIn == 2:
		sTxt += p1 + " and " + p2 + "."
	elif iIn == 3:
		var p3 = node.tOOP[tT[2]].name
		sTxt += p1 + ", " + p2 + " and " + p3 + "."
	else:
		sTxt += "all Players."

	sTxt += "![br]You now need to vote on whether to play on. Press YES to play on, NO to end the game.[br]"
	sTxt += " When all Players have voted, YES must be 100% of the votes to play on. For example, 1 YES & 1 NO means that the game is over."
	var node1 = get_tree().get_root().get_node("Spatial/CanvasLayer/UI/InGame")
	await(node1.updateGUI(sTxt, [], 2))

func endOfGame():
	var node = get_tree().get_root().get_node("Spatial")
	var sT = Messages.Msg2Txt(Globals.iWait)
	node.myDebug({"iWait": sT})
	sTxt = "That's the end of the game![br]Press OK to return to the Lobby."
	await(node.updateGUI(sTxt))

func playerQuit(iIn):
	var node = get_tree().get_root().get_node("Spatial")
	var sT = Messages.Msg2Txt(Globals.iWait)
	node.myDebug({"iWait": sT})
	var node1 = get_tree().get_root().get_node("Spatial/CanvasLayer/UI/Help")

	if node1.visible:
		node1.visible = false
	elif UniversalSettings.visible:
		UniversalSettings.quit_menu()

	sTxt = node.tOOP[iIn].name + " has unexpectedly left the server! Sorry, but the game is now over.[br]Returning to the Lobby."
	await(node.updateGUI(sTxt, [], 0))
	await get_tree().create_timer(5.0).timeout
	backToLobby()

func backToLobby():
	get_tree().change_scene_to_file("res://Menus/lobby_browsing_menu.tscn")

func populateAvailableMods():
	var node = get_tree().get_root().get_node("Spatial")
	var sT = Messages.Msg2Txt(Globals.iWait)
	node.myDebug({"iWait": sT})
	var tNum = 30 * Globals.iMyPN
	var iModMin = tNum - 29
	var iModMax = iModMin + 23
	var file = ""
	var file2 = ""
	var bFunds = false
	Globals.tAvailableMods.clear()
	Globals.tAvailableMods.append({"I": 0, "F": "Dummy.tscn", "F2": "Dummy", "N": "Dummy", "CO": 0, "CA": 0, "EP": 0, "ER": 0, "OU": 0, "ST": 0, "ON": "N", "SI": "N"})
	
	if node.tNumModules[Globals.iMyPN] == 12 and not node.tHabitation[Globals.iMyPN]:
		if node.tBank[Globals.iMyPN] >= 5:
			var id = tNum - 10

			for x in node.tMods:
				if x.id == id:
					file = "res://Scenes/Support Scenes/" + x.model
					file2 = "res://Assets/Textures/Models/" + x.model.trim_suffix(".tscn")
					Globals.tAvailableMods.append({"I": id, "F": file, "F2": file2, "N": x.name, "CO": x.cost, "CA": x.cashprod, "EP": x.energyprod, "ER": x.energyreq, "OU": x.output, "ST": x.storage, "ON": "N", "SI": "N"})

			bFunds = true
	else:
		for x in node.tMods:
			if x.id >= iModMin and x.id <= iModMax:
				if node.tBank[Globals.iMyPN] >= x.cost:
					if x.max > 0:
						file = "res://Scenes/Support Scenes/" + x.model
						file2 = "res://Assets/Textures/Models/" + x.model.trim_suffix(".tscn")
						Globals.tAvailableMods.append({"I": x.id, "F": file, "F2": file2, "N": x.name, "CO": x.cost, "CA": x.cashprod, "EP": x.energyprod, "ER": x.energyreq, "OU": x.output, "ST": x.storage, "ON": "N", "SI": "N"})

					bFunds = true

	return bFunds
 
func maxTen(iPN):
	var node = get_tree().get_root().get_node("Spatial")
	var sT = Messages.Msg2Txt(Globals.iWait)
	node.myDebug({"iWait": sT})

	if node.tREStorage[iPN].beef > 10:
		node.tREStorage[iPN].beef = 10

	if node.tREStorage[iPN].butter > 10:
		node.tREStorage[iPN].butter = 10

	if node.tREStorage[iPN].cheese > 10:
		node.tREStorage[iPN].cheese = 10

	if node.tREStorage[iPN].cream > 10:
		node.tREStorage[iPN].cream = 10

	if node.tREStorage[iPN].icecream > 10:
		node.tREStorage[iPN].icecream = 10

	if node.tREStorage[iPN].leather > 10:
		node.tREStorage[iPN].leather = 10

	if node.tREStorage[iPN].manure > 10:
		node.tREStorage[iPN].manure = 10

	if node.tREStorage[iPN].milk > 10:
		node.tREStorage[iPN].milk = 10

func moveArea(iIn, bUp):
	var node = get_tree().get_root().get_node("Spatial")
	var iY = -1
	var mod

	if bUp:
		iY = 1

	if iIn == 4:
		for x in range(9, 17):
			for y in range(7, 13):
				mod = get_tree().get_root().get_node("Spatial/Board/" + str(node.tBoardModel[x][y]))
				mod.position.y += iY
	elif iIn == 2:
		for x in range(9, 17):
			for y in range(1, 7):
				mod = get_tree().get_root().get_node("Spatial/Board/" + str(node.tBoardModel[x][y]))
				mod.position.y += iY
	elif iIn == 3:
		for x in range(1, 9):
			for y in range(7, 13):
				mod = get_tree().get_root().get_node("Spatial/Board/" + str(node.tBoardModel[x][y]))
				mod.position.y += iY
	elif iIn == 1:
		for x in range(1, 9):
			for y in range(1, 7):
				mod = get_tree().get_root().get_node("Spatial/Board/" + str(node.tBoardModel[x][y]))
				mod.position.y += iY

func checkHitLocation(inHitX, _inHitY, inHitZ):
	var node = get_tree().get_root().get_node("Spatial")
	var bXEQ = false
	var bZEQ = false
	var bXLT = false
	var bZLT = false
	var fDiffX = 0
	var fDiffZ = 0
	var fCloseX = 100
	var fCloseZ = 100
	var iLocX = 0
	var iLocY = 0
	var iBoardX = 0
	var iBoardZ = 0
	var bSquare = false

	for x in range(1, 17):
		for y in range(1, 13):
			iBoardX = node.tBoardLoc[x][y][0]
			iBoardZ = node.tBoardLoc[x][y][1]
			fDiffX = abs(iBoardX - inHitX)
			fDiffZ = abs(iBoardZ - inHitZ)

			if fDiffX <= fCloseX and fDiffZ <= fCloseZ:
				fCloseX = fDiffX
				fCloseZ = fDiffZ
				iLocX = x
				iLocY = y

	if fCloseX > 10 or fCloseZ > 10:
		return {"bOn": 0, "x": 0, "y": 0}

	iBoardX = node.tBoardLoc[iLocX][iLocY][0]
	iBoardZ = node.tBoardLoc[iLocX][iLocY][1]

	if node.tBuildings[iLocX][iLocY] > -1:
		return {"bOn": 1, "x": 0, "y": 0}

	if iBoardX == inHitX:
		bXEQ = true
	elif iBoardX < inHitX:
		bXLT = true

	if iBoardZ == inHitZ:
		bZEQ = true
	elif iBoardZ < inHitZ:
		bZLT = true

	var bRet = false
	var bRet1 = false
	bSquare = false

	if iLocX / 2.0 == floor(iLocX / 2.0):
		if iLocY / 2.0 == floor(iLocY / 2.0):
			bRet = checkOctagon(iLocX, iLocY, inHitX, inHitZ)
		else:
			bRet = checkSquare(iLocX, iLocY, inHitX, inHitZ)
			bSquare = true
	else:
		if iLocY / 2.0 == floor(iLocY / 2.0):
			bRet = checkSquare(iLocX, iLocY, inHitX, inHitZ)
			bSquare = true
		else:
			bRet = checkOctagon(iLocX, iLocY, inHitX, inHitZ)

	if bXEQ:
		if bZEQ:
			return {"bOn": 2, "x": iLocX, "y": iLocY}
		else:
			if not bRet:
				if bZLT:
					iLocY -= 1
					iBoardX = node.tBoardLoc[iLocX][iLocY][0]
					iBoardZ = node.tBoardLoc[iLocX][iLocY][1]
				else:
					iLocY += 1
					iBoardX = node.tBoardLoc[iLocX][iLocY][0]
					iBoardZ = node.tBoardLoc[iLocX][iLocY][1]

			return {"bOn": 2, "x": iLocX, "y": iLocY}
	elif bXLT:
		if bZEQ:
			if not bRet:
				iLocX -= 1
				iBoardX = node.tBoardLoc[iLocX][iLocY][0]
				iBoardZ = node.tBoardLoc[iLocX][iLocY][1]

			return {"bOn": 2, "x": iLocX, "y": iLocY}
		elif bZLT:
			if not bRet:
				iLocY -= 1
				iBoardX = node.tBoardLoc[iLocX][iLocY][0]
				iBoardZ = node.tBoardLoc[iLocX][iLocY][1]

				if bSquare:
					bRet1 = checkOctagon(iLocX, iLocY, inHitX, inHitZ)
				else:
					bRet1 = checkSquare(iLocX, iLocY, inHitX, inHitZ)

				if not bRet1:
					iLocX -= 1
					iBoardX = node.tBoardLoc[iLocX][iLocY][0]
					iBoardZ = node.tBoardLoc[iLocX][iLocY][1]

					if not bSquare:
						bRet1 = checkOctagon(iLocX, iLocY, inHitX, inHitZ)
					else:
						bRet1 = checkSquare(iLocX, iLocY, inHitX, inHitZ)

					if not bRet1:
						iLocY += 1
						iBoardX = node.tBoardLoc[iLocX][iLocY][0]
						iBoardZ = node.tBoardLoc[iLocX][iLocY][1]

			return {"bOn": 2, "x": iLocX, "y": iLocY}
		else:
			if not bRet:
				iLocY += 1
				iBoardX = node.tBoardLoc[iLocX][iLocY][0]
				iBoardZ = node.tBoardLoc[iLocX][iLocY][1]

				if bSquare:
					bRet1 = checkOctagon(iLocX, iLocY, inHitX, inHitZ)
				else:
					bRet1 = checkSquare(iLocX, iLocY, inHitX, inHitZ)

				if not bRet1:
					iLocX -= 1
					iBoardX = node.tBoardLoc[iLocX][iLocY][0]
					iBoardZ = node.tBoardLoc[iLocX][iLocY][1]

					if not bSquare:
						bRet1 = checkOctagon(iLocX, iLocY, inHitX, inHitZ)
					else:
						bRet1 = checkSquare(iLocX, iLocY, inHitX, inHitZ)

					if not bRet1:
						iLocY -= 1
						iBoardX = node.tBoardLoc[iLocX][iLocY][0]
						iBoardZ = node.tBoardLoc[iLocX][iLocY][1]

			return {"bOn": 2, "x": iLocX, "y": iLocY}
	else:
		if bZEQ:
			if not bRet:
				iLocX += 1
				iBoardX = node.tBoardLoc[iLocX][iLocY][0]
				iBoardZ = node.tBoardLoc[iLocX][iLocY][1]

			return {"bOn": 2, "x": iLocX, "y": iLocY}
		elif bZLT:
			if not bRet:
				iLocY -= 1
				iBoardX = node.tBoardLoc[iLocX][iLocY][0]
				iBoardZ = node.tBoardLoc[iLocX][iLocY][1]

				if bSquare:
					bRet1 = checkOctagon(iLocX, iLocY, inHitX, inHitZ)
				else:
					bRet1 = checkSquare(iLocX, iLocY, inHitX, inHitZ)

				if not bRet1:
					iLocX += 1
					iBoardX = node.tBoardLoc[iLocX][iLocY][0]
					iBoardZ = node.tBoardLoc[iLocX][iLocY][1]

					if not bSquare:
						bRet1 = checkOctagon(iLocX, iLocY, inHitX, inHitZ)
					else:
						bRet1 = checkSquare(iLocX, iLocY, inHitX, inHitZ)

					if not bRet1:
						iLocY += 1
						iBoardX = node.tBoardLoc[iLocX][iLocY][0]
						iBoardZ = node.tBoardLoc[iLocX][iLocY][1]

			return {"bOn": 2, "x": iLocX, "y": iLocY}
		else:
			if not bRet:
				iLocY += 1
				iBoardX = node.tBoardLoc[iLocX][iLocY][0]
				iBoardZ = node.tBoardLoc[iLocX][iLocY][1]

				if bSquare:
					bRet1 = checkOctagon(iLocX, iLocY, inHitX, inHitZ)
				else:
					bRet1 = checkSquare(iLocX, iLocY, inHitX, inHitZ)

				if not bRet1:
					iLocX += 1
					iBoardX = node.tBoardLoc[iLocX][iLocY][0]
					iBoardZ = node.tBoardLoc[iLocX][iLocY][1]

					if not bSquare:
						bRet1 = checkOctagon(iLocX, iLocY, inHitX, inHitZ)
					else:
						bRet1 = checkSquare(iLocX, iLocY, inHitX, inHitZ)

					if not bRet1:
						iLocY -= 1
						iBoardX = node.tBoardLoc[iLocX][iLocY][0]
						iBoardZ = node.tBoardLoc[iLocX][iLocY][1]

			return {"bOn": 2, "x": iLocX, "y": iLocY}

func checkSquare(inX, inY, inHX, inHZ):
	var node = get_tree().get_root().get_node("Spatial")
	var bX = node.tBoardLoc[inX][inY][0]
	var bZ = node.tBoardLoc[inX][inY][1]
	var fMinX = bX - 1.85
	var fMaxX = bX + 1.85
	var fMinZ = bZ - 1.85
	var fMaxZ = bZ + 1.85

	if inHZ > fMinZ and inHZ < fMaxZ and inHX > fMinX and inHX < fMaxX:
		return true
	else:
		return false

func checkOctagon(inX, inY, inHX, inHZ):
	var node = get_tree().get_root().get_node("Spatial")
	var bX = node.tBoardLoc[inX][inY][0]
	var bZ = node.tBoardLoc[inX][inY][1]
	var fMinX = bX - 5.55
	var fMaxX = bX + 5.55
	var fMinZ = bZ - 5.55
	var fMaxZ = bZ + 5.55

	if inHZ > fMinZ and inHZ < fMaxZ and inHX > fMinX and inHX < fMaxX:
		return true
	else:
		return false

func addIcon(inX, inY, iSick, iOnline):
	var node = get_tree().get_root().get_node("Spatial")
	var sT = Messages.Msg2Txt(Globals.iWait)
	node.myDebug({"iWait": sT, "inX": inX, "inY": inY, "iSick": iSick, "iOnline": iOnline})
	var sIcon = null
	node.vPos.x = node.tBoardLoc[inX][inY][0]
	node.vPos.y = 4
	node.vPos.z = node.tBoardLoc[inX][inY][1]
	var vTScale = Vector3(0.1, 0.1, 0.1)

	if iOnline == 1:
		if node.tOfflineIcons[inX][inY] > -1:
			var sT1 = "Spatial/Buildings/" + str(node.tModels[inX][inY]) + "/" + str(node.tOfflineIcons[inX][inY])
			freeNode(sT1)
			GDSync.call_func(freeNode, [sT1])
			sIcon = get_tree().get_root().get_node(sT1)
			sIcon.queue_free()
			node.tOfflineIcons[inX][inY] = -1
			node.updateModules(inX, inY, 1, "Y")
			GDSync.call_func(node.updateModules, [inX, inY, 1, "Y"])
	elif iOnline == 0:
		if node.tOfflineIcons[inX][inY] == -1:
			vTScale.x = 0.01
			vTScale.y = 0.01
			vTScale.z = 0.01
			sIcon = load("res://Scenes/Support Scenes/lightning.tscn")
			var n = get_tree().get_root().get_node("Spatial/Buildings/" + str(node.tModels[inX][inY]) + "/" + str(node.tOfflineIcons[inX][inY]))
			var object = GDSync.multiplayer_instantiate(sIcon, n, true, [], false)
			GDSync.set_gdsync_owner(n, GDSync.get_client_id())
			node.tOfflineIcons[inX][inY] = object.get_name()
			node.updateModules(inX, inY, 1, "N")
			GDSync.call_func(node.updateModules, [inX, inY, 1, "N"])
			sIcon.set_position(node.vPos)
			sIcon.set_scale(vTScale)
			sIcon.set_visible(true)

	if iSick == 1:
		if node.tSickIcons[inX][inY] == -1:
			sIcon = load("res://Scenes/Support Scenes/cross.tscn")
			var n = get_tree().get_root().get_node("Spatial/Buildings/" + str(node.tModels[inX][inY]) + "/" + str(node.tSickIcons[inX][inY]))
			var object = GDSync.multiplayer_instantiate(sIcon, n, true, [], false)
			GDSync.set_gdsync_owner(n, GDSync.get_client_id())
			node.tSickIcons[inX][inY] = object.get_name()
			node.updateModules(inX, inY, 0, "Y")
			GDSync.call_func(node.updateModules, [inX, inY, 0, "Y"])
			sIcon.set_position(node.vPos)
			sIcon.set_scale(vTScale)
			sIcon.set_visible(true)
	elif iSick == 0:
		if node.tSickIcons[inX][inY] > -1:
			var sT1 = "Spatial/Buildings/" + str(node.tModels[inX][inY]) + "/" + str(node.tSickIcons[inX][inY])
			freeNode(sT1)
			GDSync.call_func(freeNode, [sT1])
			sIcon = get_tree().get_root().get_node(sT1)
			sIcon.queue_free()
			node.tSickIcons[inX][inY] = -1
			node.updateModules(inX, inY, 0, "N")
			GDSync.call_func(node.updateModules, [inX, inY, 0, "N"])

	moveCamera(node.tBoardLoc[inX][inY][0], node.tBoardLoc[inX][inY][1])

func chkSquare(inMin, inMax, inX, inY):
	var node = get_tree().get_root().get_node("Spatial")
	var xx = inX - 1
	var yy = inY

	if inX > 1:
		if node.tBuildings[xx][yy] >= inMin and node.tBuildings[xx][yy] <= inMax:
			return true

	if inX < 16:
		xx = inX + 1

		if node.tBuildings[xx][yy] >= inMin and node.tBuildings[xx][yy] <= inMax:
			return true

	if inY > 1:
		xx = inX
		yy = inY - 1

		if node.tBuildings[xx][yy] >= inMin and node.tBuildings[xx][yy] <= inMax:
			return true

	if inY < 12:
		xx = inX
		yy = inY + 1

		if node.tBuildings[xx][yy] >= inMin and node.tBuildings[xx][yy] <= inMax:
			return true

	return false

func chkOctagon(inMin, inMax, inX, inY):
	var node = get_tree().get_root().get_node("Spatial")

	if chkSquare(inMin, inMax, inX, inY):
		return true
	else:
		var xx = inX - 1
		var yy = inY - 1

		if inX > 1 and inY > 1:
			if node.tBuildings[xx][yy] >= inMin and node.tBuildings[xx][yy] <= inMax:
				return true

		if inX < 16 and inY > 1:
			xx = inX + 1

			if node.tBuildings[xx][yy] >= inMin and node.tBuildings[xx][yy] <= inMax:
				return true

		if inX > 1 and inY < 12:
			xx = inX - 1
			yy = inY + 1

			if node.tBuildings[xx][yy] >= inMin and node.tBuildings[xx][yy] <= inMax:
				return true

		if inX < 16 and inY < 12:
			xx = inX + 1
			yy = inY + 1

			if node.tBuildings[xx][yy] >= inMin and node.tBuildings[xx][yy] <= inMax:
				return true

		return false

func randomEventDice():
	var node = get_tree().get_root().get_node("Spatial")
	var sT = Messages.Msg2Txt(Globals.iWait)
	node.myDebug({"iWait": sT})
	var node1 = get_tree().get_root().get_node("Spatial/CanvasLayer/UI/InGame")
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var iPN = node.iCurPlay
	var iBtn = 0
	sT = ""
	sTxt = "[RANDOM EVENT][br]You rolled a " + str(Globals.iDice1) + " and a " + str(Globals.iDice2) + "![br]"
	sTxt += randomEventText()

	match Globals.iDice1:
		1:
			match Globals.iDice2:
				1:
					var tStor = [0, 0, 0, 0, 0, 0, 0, 0, 0]

					tStor[1] = node.tREStorage[iPN].beef
					tStor[2] = node.tREStorage[iPN].butter
					tStor[3] = node.tREStorage[iPN].cheese
					tStor[4] = node.tREStorage[iPN].cream
					tStor[5] = node.tREStorage[iPN].icecream
					tStor[6] = node.tREStorage[iPN].leather
					tStor[7] = node.tREStorage[iPN].manure
					tStor[8] = node.tREStorage[iPN].milk

					var iMax = tStor[1]
					var iStore = 1

					for x in range(2, 9):
						if tStor[x] > iMax:
							iMax = tStor[x]
						elif tStor[x] == iMax:
							var iRand = rng.irand_range(1, 100)

							if iRand > 50:
								iStore = x

					var iT = 0
					sT = ""

					match iStore:
						1:
							node.tREStorage[iPN].beef = ceil(node.tREStorage[iPN].beef / 2.0)
							iT = node.tREStorage[iPN].beef
							sT = "BEEF"
						2:
							node.tREStorage[iPN].butter = ceil(node.tREStorage[iPN].butter / 2.0)
							iT = node.tREStorage[iPN].butter
							sT = "BUTTER"
						3:
							node.tREStorage[iPN].cheese = ceil(node.tREStorage[iPN].cheese / 2.0)
							iT = node.tREStorage[iPN].cheese
							sT = "CHEESE"
						4:
							node.tREStorage[iPN].cream = ceil(node.tREStorage[iPN].cream / 2.0)
							iT = node.tREStorage[iPN].cream
							sT = "CREAM"
						5:
							node.tREStorage[iPN].icecream = ceil(node.tREStorage[iPN].icecream / 2.0)
							iT = node.tREStorage[iPN].icecream
							sT = "ICECREAM"
						6:
							node.tREStorage[iPN].leather = ceil(node.tREStorage[iPN].leather / 2.0)
							iT = node.tREStorage[iPN].leather
							sT = "LEATHER"
						7:
							node.tREStorage[iPN].manure = ceil(node.tREStorage[iPN].manure / 2.0)
							iT = node.tREStorage[iPN].manure
							sT = "MANURE"
						_:
							node.tREStorage[iPN].milk = ceil(node.tREStorage[iPN].milk / 2.0)
							iT = node.tREStorage[iPN].milk
							sT = "MILK"

					sTxt += "[br]This means you lose half of your " + sT + " Storage! The quantity you now have is " + str(iT) + "."
				2:
					if node.tREStorage[iPN].milk < 10:
						node.tREPrices[iPN].milk += 1
				3:
					if not node.tPastureDome[iPN]:
						node.tREStorage[iPN].cheese = 0
						node.tREStorage[iPN].cream = 0
						node.tREStorage[iPN].milk = 0
				4:
					if node.tPastureDome[iPN]:
						node.tREStorage[iPN].beef += 2
						node.tREStorage[iPN].butter += 2
						node.tREStorage[iPN].cheese += 2
						node.tREStorage[iPN].cream += 2
						node.tREStorage[iPN].icecream += 2
						node.tREStorage[iPN].leather += 2
						node.tREStorage[iPN].manure += 2
						node.tREStorage[iPN].milk += 2

						maxTen(iPN)
					else:
						sTxt += "[br]But, since you don't have at least 1 Pasture Dome for every 3 Barns, you can't get the benefit!"
				5:
					Globals.tREOther[iPN].keepunsold = true
				6:
					if node.tREPrices[iPN].butter > 0:
						node.tREPrices[iPN].butter -= 1
		2:
			match Globals.iDice2:
				1:
					if node.tREPrices[iPN].cream < 10:
						node.tREPrices[iPN].cream += 1
				2:
					if node.tREPrices[iPN].cheese > 0:
						node.tREPrices[iPN].cheese -= 1
				3:
					Globals.tREOther[iPN].losegeo = true
					Globals.iGeothermal = 0
					Globals.iCrystal = 0

					var tNum1 = 30 * node.iCurPlay - 27
					var tNum2 = 30 * node.iCurPlay - 28

					for x in range(1, 17):
						for y in range(1, 13):
							if node.tBuildings[x][y] == tNum1:
								if node.tModules[x][y].online == "Y":
									Globals.iGeothermal += 1

					if Globals.iGeothermal > 0:
						Globals.iWait = Messages.Msg.LOSE_GEOTHERMAL
						sTxt += "[br]Please mark a Geothermal Powerplant offline."
						iBtn = 1
					else:
						for x in range(1, 17):
							for y in range(1, 13):
								if node.tBuildings[x][y] == tNum2:
									if node.tModules[x][y].online == "Y":
										Globals.iCrystal += 1

						if Globals.iCrystal > 0:
							Globals.iWait = Messages.Msg.LOSE_CRYSTAL
							sTxt += "[br]Please mark a Crystal Powerplant offline."
							iBtn = 1
						else:
							sTxt += "[br]You don't have any online Geothermal or Crystal Powerplants, so can't mark any offline."
				4:
					if node.tREPrices[iPN].leather < 10:
						node.tREPrices[iPN].leather += 1
				5:
					if node.tREPrices[iPN].cream > 0:
						node.tREPrices[iPN].cream -= 1
				6:
					node.tREStorage[iPN].beef = 0
					node.tREStorage[iPN].butter = 0
					node.tREStorage[iPN].cheese = 0
					node.tREStorage[iPN].cream = 0
					node.tREStorage[iPN].icecream = 0
					node.tREStorage[iPN].leather = 0
					node.tREStorage[iPN].milk = 0
		3:
			match Globals.iDice2:
				1:
					if node.tREPrices[iPN].icecream < 10:
						node.tREPrices[iPN].icecream += 1
				2:
					if node.tREPrices[iPN].beef > 0:
						node.tREPrices[iPN].beef -= 1

					if node.tREPrices[iPN].butter > 0:
						node.tREPrices[iPN].butter -= 1

					if node.tREPrices[iPN].cheese > 0:
						node.tREPrices[iPN].cheese -= 1

					if node.tREPrices[iPN].cream > 0:
						node.tREPrices[iPN].cream -= 1

					if node.tREPrices[iPN].icecream > 0:
						node.tREPrices[iPN].icecream -= 1

					if node.tREPrices[iPN].leather > 0:
						node.tREPrices[iPN].leather -= 1

					if node.tREPrices[iPN].milk > 0:
						node.tREPrices[iPN].milk -= 1
				3:
					if node.tREPrices[iPN].butter < 10:
						node.tREPrices[iPN].butter += 1
				4:
					if node.tREPrices[iPN].leather > 0:
						node.tREPrices[iPN].leather -= 1
				5:
					if node.tNumDisease[iPN] < 4:
						Globals.tREOther[iPN].newdisease = true
						Globals.iBarn = 0
						Globals.iMegaBarn = 0
						var tNum1 = 30 * node.iCurPlay - 13
						var tNum2 = 30 * node.iCurPlay - 12

						for x in range(1, 17):
							for y in range(1, 13):
								if node.tBuildings[x][y] == tNum1:
									if node.tModules[x][y].online == "Y":
										Globals.iBarn += 1

						if Globals.iBarn > 0:
							Globals.iWait = Messages.Msg.SICK_BARN
							sTxt += "[br]Please mark a Barn as sick."
							iBtn = 1
						else:
							for x in range(1, 17):
								for y in range(1, 13):
									if node.tBuildings[x][y] == tNum2:
										if node.tModules[x][y].online == "Y":
											Globals.iMegaBarn += 1

							if Globals.iMegaBarn > 0:
								Globals.iWait = Messages.Msg.SICK_MEGABARN
								sTxt += "[br]Please mark a MegaBarn as sick."
								iBtn = 1
							else:
								sTxt += "[br]You don't have any online Barns or MegaBarns, so can't mark any as sick."
					else:
						Globals.tREOther[iPN].newdisease = false
						sTxt += "[br]Since you already have 4 diseases, you do not have to mark a Barn or Megabarn as sick."
				6:
					if node.tREPrices[iPN].milk > 0:
						node.tREPrices[iPN].milk -= 1
		4:
			match Globals.iDice2:
				1:
					if node.tREPrices[iPN].cheese < 10:
						node.tREPrices[iPN].cheese += 1
				2:
					if node.tPastureDome[iPN]:
						node.tREStorage[iPN].beef *= 2
						node.tREStorage[iPN].butter *= 2
						node.tREStorage[iPN].cheese *= 2
						node.tREStorage[iPN].cream *= 2
						node.tREStorage[iPN].icecream *= 2
						node.tREStorage[iPN].leather *= 2
						node.tREStorage[iPN].manure *= 2
						node.tREStorage[iPN].milk *= 2

						maxTen(iPN)
					else:
						sTxt += "[br]But, since you don't have at least 1 Pasture Dome for every 3 Barns, you can't get the benefit!"
				3:
					if not node.tPastureDome[iPN]:
						node.tREStorage[iPN].beef = ceil(node.tREStorage[iPN].beef / 2.0)
						node.tREStorage[iPN].butter = ceil(node.tREStorage[iPN].butter / 2.0)
						node.tREStorage[iPN].cheese = ceil(node.tREStorage[iPN].cheese / 2.0)
						node.tREStorage[iPN].cream = ceil(node.tREStorage[iPN].cream / 2.0)
						node.tREStorage[iPN].icecream = ceil(node.tREStorage[iPN].icecream / 2.0)
						node.tREStorage[iPN].leather = ceil(node.tREStorage[iPN].leather / 2.0)
						node.tREStorage[iPN].manure = ceil(node.tREStorage[iPN].manure / 2.0)
						node.tREStorage[iPN].milk = ceil(node.tREStorage[iPN].milk / 2.0)
					else:
						sTxt += "[br]But, since you have at least 1 Pasture Dome for every 3 Barns, you don't have to take the hit!"
				4:
					Globals.tREOther[iPN].labs = 10
				5:
					if node.tREPrices[iPN].beef > 0:
						node.tREPrices[iPN].beef -= 1
				6:
					if node.tPastureDome[iPN]:
						Globals.tREOther[iPN].cureall = true
						resetNumDisease(iPN)
						GDSync.call_func(resetNumDisease, [iPN])
						var tNum1 = 30 * node.iCurPlay - 13
						var tNum2 = 30 * node.iCurPlay - 12

						for x in range(1, 17):
							for y in range(1, 13):
								if node.tBuildings[x][y] == tNum1 or node.tBuildings[x][y] == tNum2:
									node.updateModules(x, y, 0, "N")
									GDSync.call_func(node.updateModules, [x, y, 0, "N"])
									var sT1 = "Spatial/Buildings/" + str(node.tModels[x][y]) + "/" + str(node.tSickIcons[x][y])
									freeNode(sT1)
									GDSync.call_func(freeNode, [sT1])
									var sIcon = get_tree().get_root().get_node(sT1)
									sIcon.queue_free()
									node.tSickIcons[x][y] = -1
					else:
						sTxt += "[br]But, since you don't have at least 1 Pasture Dome for every 3 Barns, you can't get the benefit!"
		5:
			match Globals.iDice2:
				1:
					Globals.tREOther[iPN].losebarn = true
					Globals.iBarn = 0
					var tNum1 = 30 * node.iCurPlay - 13
					var tNum2 = 30 * node.iCurPlay - 12

					for x in range(1, 17):
						for y in range(1, 13):
							if node.tBuildings[x][y] == tNum1 or node.tBuildings[x][y] == tNum2:
								Globals.iBarn += 1

					if Globals.iBarn > 0:
						Globals.iWait = Messages.Msg.REMOVE_BARN
						sTxt += "[br]Please remove a Barn or Megabarn."
						iBtn = 1
					else:
						sTxt += "[br]You don't have any Barns or MegaBarns to remove."
				2:
					if node.tREPrices[iPN].beef < 10:
						node.tREPrices[iPN].beef += 1
				3:
					if node.tREPrices[iPN].beef < 10:
						node.tREPrices[iPN].beef += 1

					if node.tREPrices[iPN].cheese > 0:
						node.tREPrices[iPN].cheese -= 1

					if node.tREPrices[iPN].leather < 10:
						node.tREPrices[iPN].leather += 1

					if node.tREPrices[iPN].milk > 0:
						node.tREPrices[iPN].milk -= 1
				4:
					if node.tREPrices[iPN].icecream > 0:
						node.tREPrices[iPN].icecream -= 1
				5:
					Globals.tREOther[iPN].giftboxes = 15
				6:
					if node.tREPrices[iPN].cream > 0:
						node.tREPrices[iPN].cream -= 1

					if node.tREPrices[iPN].icecream < 10:
						node.tREPrices[iPN].icecream += 2
		6:
			match Globals.iDice2:
				1:
					if node.tREPrices[iPN].manure < 10:
						node.tREPrices[iPN].manure += 2
				2:
					if not node.tPastureDome[iPN]:
						node.tREStorage[iPN].beef = 0
						node.tREStorage[iPN].icecream = 0
						node.tREStorage[iPN].leather = 0
					else:
						sTxt += "[br]But, since you have at least 1 Pasture Dome for every 3 Barns, you don't have to take the hit!"
				3:
					Globals.tREOther[iPN].reroll = true
				4:
					Globals.tREOther[iPN].nocatalog = true
				5:
					node.tREPrices[iPN].manure = 0
				6:
					node.tREPrices[iPN].beef += 1
					node.tREPrices[iPN].butter += 1
					node.tREPrices[iPN].cheese += 1
					node.tREPrices[iPN].cream += 1
					node.tREPrices[iPN].icecream += 1
					node.tREPrices[iPN].leather += 1
					node.tREPrices[iPN].manure += 1
					node.tREPrices[iPN].milk += 1

					maxTen(iPN)

	if iBtn == 0:
		sTxt += "[br]Press OK to continue."
		await(node1.updateGUI(sTxt))
		Globals.iWait = Messages.Msg.RE_OUTCOME
	else:
		sTxt += " Press DONE to finish your turn."
		await(node1.updateGUI(sTxt, [], 6))

func randomEventText():
	var node = get_tree().get_root().get_node("Spatial")
	var sT = Messages.Msg2Txt(Globals.iWait)
	node.myDebug({"iWait": sT, "iDice1": Globals.iDice1, "iDice2": Globals.iDice2})

	match Globals.iDice1:
		1:
			match Globals.iDice2:
				1:
					sT = " Your barn door is open! Whatever you've stored the most of, the server will decide if it's a tie, you lose half of it, dropping fractions."
				2:
					sT = " Bull market on Wall Street! Milk prices plus 1."
				3:
					sT = " Your cows are not content! If you don't have at least 1 Pasture per 3 Barns, reduce stored Milk, Cream & Cheese to 0."
				4:
					sT = " Papal bull arrives! Holy cow!. Add 2 to your inventory for all stored products, but not more than storage capacity."
				5:
					sT = " BHA added as a preservative! Don't reset your unsold products to 0 at the end of this turn."
				_:
					sT = " Employee charged with assault & buttery! Butter prices minus 1."
		2:
			match Globals.iDice2:
				1:
					sT = " Cream of the crop! Cream prices plus 1."
				2:
					sT = " Somebody cut the cheese! Cheese prices minus 1."
				3:
					sT = " What now, brown cow? Lose 1 Geothermal Plant, or Solar Panel if you have no Geothermal Plants."
				4:
					sT = " Interplanetary Hell's Angels tour your colony! Leather prices plus 1."
				5:
					sT = " Cows object to cold milking machines! Cream prices minus 1."
				_:
					sT = " Your bulls go on strike for heifer and heifer! Reduce all stored products except Manure to 0."
		3:
			match Globals.iDice2:
				1:
					sT = " Your assets are frozen! Ice cream prices plus 1."
				2:
					sT = " Your sacred cow runs off with a Brahma bull! All product prices except Manure are minus 1."
				3:
					sT = " Land O'Lakes dairymaid's knees cause a scandal! Butter prices plus 1."
				4:
					sT = " You get a bum steer! Leather prices minus 1."
				5:
					sT = " Mad cows! Well, they aren't pleased. 1 disease breaks out."
				_:
					sT = " Your cows are distracted by the Chicago Bulls on TV! Milk prices minus 1."
		4:
			match Globals.iDice2:
				1:
					sT = " Limburger becomes a trendy favorite! Cheese prices plus 1."
				2:
					sT = " Contented cows put in some overtime! If you have at least 1 Pasture for each 3 Barns, double each stored product, but not more than storage capacity."
				3:
					sT = " Militant animal-rights activists tour your colony! If you don't have at least 1 Pasture per 3 Barns, they destroy half of all stored products, dropping fractions."
				4:
					sT = " Your cattle go into orbit! The herd shot around the world. Labs generate $10 each."
				5:
					sT = " Tofu burgers surge in popularity! Beef prices minus 1."
				_:
					sT = " Your cows get pasturised! If you have at least 1 Pasture for each 3 Barns, all diseases are cured."
		5:
			match Globals.iDice2:
				1:
					sT = " Saboteurs sneak explosives into your herds! Abominable! Remove 1 Barn module."
				2:
					sT = " Where's the beef? Beef prices plus 1."
				3:
					sT = " Bullfighters' Union tours your colony! Milk and Cheese prices minus 1, Beef and Leather prices plus 1."
				4:
					sT = " Your accountants went cow-tipping! Ice cream prices minus 1."
				5:
					sT = " Green Bay Packers win the Super Bowl! Gift box prices are $15."
				_:
					sT = " Baskin-Robbins merges with Hood Ice Cream, becomes Robbin-Hood! Cream prices minus 1, Ice Cream prices plus 2."
		_:
			match Globals.iDice2:
				1:
					sT = " Congress tours your colony! Manure price is up to 2."
				2:
					sT = " Your cows are udderly fed up with their working conditions! If you don't have at least 1 Pasture per 3 Barns, reduce stored Beef, Ice Cream & Leather to 0."
				3:
					sT = " Civil War re-enactors perform the Battle of Bull Run at your colony! Reroll any product price that comes up 1, except Manure."
				4:
					sT = " Dallas Cowboys endorse your colony's products and demand skyrockets! Sell gift boxes even if you don't have a Catalog Store."
				5:
					sT = " Congress recesses! Manure price 0."
				_:
					sT = " To err is human, to forgive bovine! All product prices plus 1."

	return sT

func updateAvailArea(iIn, bIn = false):
	var node = get_tree().get_root().get_node("Spatial")

	if not bIn:
		Globals.iAvailArea = iIn
	else:
		Globals.iAvailArea = 0

	node.tAvailArea[iIn] = bIn

func resetNumDisease(iIn):
	var node = get_tree().get_root().get_node("Spatial")
	node.tNumDisease[iIn] = 0

func updatePrices(iIn, iIn2):
	var node = get_tree().get_root().get_node("Spatial")
	node.tPrices[iIn] = iIn2

func freeNode(inS):
	var node = get_tree().get_root().get_node(inS)
	node.queue_free()

func moveCamera(inX, inZ):
	var sCam = get_tree().get_root().get_node("Spatial/Camera")
	sCam.position = Vector3(inX, 15, inZ + 22.5)
	sCam.rotation = Vector3(-30, 0, 0)

func otherPlayer(inTxt):
	var node = get_tree().get_root().get_node("Spatial")
	sTxt = inTxt + "It's " + node.tOOP[node.iCurPlay].name + "'s turn! Please wait whilst they complete their turn."
	sTxtSpeech = inTxt + "It's " + node.tOOP[node.iCurPlay].name + "s turn. Please wait whilst they complete their turn."
	var node1 = get_tree().get_root().get_node("Spatial/CanvasLayer/UI/InGame")
	await(node1.updateGUI(sTxt, [], 0, sTxtSpeech))
