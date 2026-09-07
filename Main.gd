extends Node

@onready var inGame = $CanvasLayer/UI/InGame
@onready var help = $CanvasLayer/UI/Help
@onready var ui = $CanvasLayer/UI
@onready var popup = $Popup
@onready var btnOK = $Popup/VBoxContainer/HBoxContainer/btnOK
@onready var Sfx = $Sfx

# tAvailArea = used to place Start Ups - stops players choosing the same area
var tAvailArea = [true, true, true, true, true]
# tBank = Bank Accounts [1 - 4] = player number
var tBank = [100, 100, 100, 100, 100]
# tBarns = Contains Location of Barns{"I": "Barn/MegaBarn", "X": x, "Y": y}
var tBarns = []
# tBoard = Contains Type of Board Piece at Location [0 = SQUARE, 1 = OCTAGON, 2 = SQUARE FISSURE, 3 = OCTAGON FISSURE, 4 = SQUARE GRASS, 5 = OCTAGON GRASS]
var tBoard = [
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]				# Board Layout
# tBoardLoc = Contains x & y co-ordinates of Board Piece at Location
var tBoardLoc = [
	[[0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0]],
	[[0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0]],
	[[0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0]],
	[[0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0]],
	[[0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0]],
	[[0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0]],
	[[0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0]],
	[[0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0]],
	[[0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0]],
	[[0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0]],
	[[0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0]],
	[[0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0]],
	[[0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0]],
	[[0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0]],
	[[0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0]],
	[[0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0]],
	[[0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0]]]			# Board Locations in 3D [x][y][1 - 2]
# tBoardModel = Contains ID of Board Piece at Location
var tBoardModel = [
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]		# [x][y] Model at Board Location
# tBuildings = Contains ID of Type of Building at Location - for example, 1 = Startup Module, 2 = Solar Powerplant etc.
var tBuildings = [
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]]			# [x][y] SCC Building Number
# tCatalog = Does Player have a Catalog Store? [1 - 4] = true or false
var tCatalog = [false, false, false, false, false]
# tCheeseLab = Does Player have a Cheese Lab? [1 - 4] = true or false
var tCheeseLab = [false, false, false, false, false]
# tConstruction = Does Player have a Construction Module? [1 - 4] = true or false
var tConstruction = [false, false, false, false, false]
# tModels = Contains Godot ID of Building at Location
var tModels = [
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]]			# [x][y] Godot IDs of SCC Buildings
# tMods = Details for each Type of Building - ID, Name, Max #, Model, Cost, Cash Produced, Energy Produced, Energy Required, Output & Storage
var tMods = [
	{
	  "id": 31,
	  "name": "Start Up",
	  "max": 1,
	  "model": "crystal_farm_blue.tscn",
	  "cost": 20,
	  "cashprod": 2,
	  "energyprod": 2,
	  "energyreq": 0,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 91,
	  "name": "Start Up",
	  "max": 1,
	  "model": "crystal_farm_green.tscn",
	  "cost": 20,
	  "cashprod": 2,
	  "energyprod": 2,
	  "energyreq": 0,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 1,
	  "name": "Start Up",
	  "max": 1,
	  "model": "crystal_farm_red.tscn",
	  "cost": 20,
	  "cashprod": 2,
	  "energyprod": 2,
	  "energyreq": 0,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 61,
	  "name": "Start Up",
	  "max": 1,
	  "model": "crystal_farm_yellow.tscn",
	  "cost": 20,
	  "cashprod": 2,
	  "energyprod": 2,
	  "energyreq": 0,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 32,
	  "name": "Crystal Powerplant",
	  "max": 3,
	  "model": "crystal_powerplant_blue.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 3,
	  "energyreq": 0,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 92,
	  "name": "Crystal Powerplant",
	  "max": 3,
	  "model": "crystal_powerplant_green.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 3,
	  "energyreq": 0,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 2,
	  "name": "Crystal Powerplant",
	  "max": 3,
	  "model": "crystal_powerplant_red.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 3,
	  "energyreq": 0,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 62,
	  "name": "Crystal Powerplant",
	  "max": 3,
	  "model": "crystal_powerplant_yellow.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 3,
	  "energyreq": 0,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 33,
	  "name": "Geothermal Powerplant",
	  "max": 4,
	  "model": "power_plant_blue.tscn",
	  "cost": 10,
	  "cashprod": 0,
	  "energyprod": 6,
	  "energyreq": 0,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 93,
	  "name": "Geothermal Powerplant",
	  "max": 4,
	  "model": "power_plant_green.tscn",
	  "cost": 10,
	  "cashprod": 0,
	  "energyprod": 6,
	  "energyreq": 0,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 3,
	  "name": "Geothermal Powerplant",
	  "max": 4,
	  "model": "power_plant_red.tscn",
	  "cost": 10,
	  "cashprod": 0,
	  "energyprod": 6,
	  "energyreq": 0,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 63,
	  "name": "Geothermal Powerplant",
	  "max": 4,
	  "model": "power_plant_yellow.tscn",
	  "cost": 10,
	  "cashprod": 0,
	  "energyprod": 6,
	  "energyreq": 0,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 38,
	  "name": "Hub",
	  "max": 4,
	  "model": "rocket_silo_blue.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 0,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 98,
	  "name": "Hub",
	  "max": 4,
	  "model": "rocket_silo_green.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 0,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 8,
	  "name": "Hub",
	  "max": 4,
	  "model": "rocket_silo_red.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 0,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 68,
	  "name": "Hub",
	  "max": 4,
	  "model": "rocket_silo_yellow.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 0,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 35,
	  "name": "Portal",
	  "max": 1,
	  "model": "portal_blue.tscn",
	  "cost": 10,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 95,
	  "name": "Portal",
	  "max": 1,
	  "model": "portal_green.tscn",
	  "cost": 10,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 5,
	  "name": "Portal",
	  "max": 1,
	  "model": "portal_red.tscn",
	  "cost": 10,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 65,
	  "name": "Portal",
	  "max": 1,
	  "model": "portal_yellow.tscn",
	  "cost": 10,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 47,
	  "name": "Barn",
	  "max": 7,
	  "model": "depot_blue.tscn",
	  "cost": 10,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 5,
	  "storage": 0
	},
	{
	  "id": 107,
	  "name": "Barn",
	  "max": 7,
	  "model": "depot_green.tscn",
	  "cost": 10,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 5,
	  "storage": 0
	},
	{
	  "id": 17,
	  "name": "Barn",
	  "max": 7,
	  "model": "depot_red.tscn",
	  "cost": 10,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 5,
	  "storage": 0
	},
	{
	  "id": 77,
	  "name": "Barn",
	  "max": 7,
	  "model": "depot_yellow.tscn",
	  "cost": 10,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 5,
	  "storage": 0
	},
	{
	  "id": 48,
	  "name": "Mega Barn",
	  "max": 1,
	  "model": "storage_blue.tscn",
	  "cost": 20,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 10,
	  "storage": 0
	},
	{
	  "id": 108,
	  "name": "Mega Barn",
	  "max": 1,
	  "model": "storage_green.tscn",
	  "cost": 20,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 10,
	  "storage": 0
	},
	{
	  "id": 18,
	  "name": "Mega Barn",
	  "max": 1,
	  "model": "storage_red.tscn",
	  "cost": 20,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 10,
	  "storage": 0
	},
	{
	  "id": 78,
	  "name": "Mega Barn",
	  "max": 1,
	  "model": "storage_yellow.tscn",
	  "cost": 20,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 10,
	  "storage": 0
	},
	{
	  "id": 49,
	  "name": "Processing Plant",
	  "max": 2,
	  "model": "factory_blue.tscn",
	  "cost": 20,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 2,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 109,
	  "name": "Processing Plant",
	  "max": 2,
	  "model": "factory_green.tscn",
	  "cost": 20,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 2,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 19,
	  "name": "Processing Plant",
	  "max": 2,
	  "model": "factory_red.tscn",
	  "cost": 20,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 2,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 79,
	  "name": "Processing Plant",
	  "max": 2,
	  "model": "factory_yellow.tscn",
	  "cost": 20,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 2,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 53,
	  "name": "Pasture Dome",
	  "max": 3,
	  "model": "biosphere_blue.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 113,
	  "name": "Pasture Dome",
	  "max": 3,
	  "model": "biosphere_green.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 23,
	  "name": "Pasture Dome",
	  "max": 3,
	  "model": "biosphere_red.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 83,
	  "name": "Pasture Dome",
	  "max": 3,
	  "model": "biosphere_yellow.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 39,
	  "name": "Beef Store",
	  "max": 1,
	  "model": "tower_blue.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 10
	},
	{
	  "id": 99,
	  "name": "Beef Store",
	  "max": 1,
	  "model": "tower_green.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 10
	},
	{
	  "id": 9,
	  "name": "Beef Store",
	  "max": 1,
	  "model": "tower_red.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 10
	},
	{
	  "id": 69,
	  "name": "Beef Store",
	  "max": 1,
	  "model": "tower_yellow.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 10
	},
	{
	  "id": 40,
	  "name": "Butter Store",
	  "max": 1,
	  "model": "fuel_depot_blue.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 10
	},
	{
	  "id": 100,
	  "name": "Butter Store",
	  "max": 1,
	  "model": "fuel_depot_green.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 10
	},
	{
	  "id": 10,
	  "name": "Butter Store",
	  "max": 1,
	  "model": "fuel_depot_red.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 10
	},
	{
	  "id": 70,
	  "name": "Butter Store",
	  "max": 1,
	  "model": "fuel_depot_yellow.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 10
	},
	{
	  "id": 41,
	  "name": "Cheese Store",
	  "max": 1,
	  "model": "tower_blue.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 10
	},
	{
	  "id": 101,
	  "name": "Cheese Store",
	  "max": 1,
	  "model": "tower_green.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 10
	},
	{
	  "id": 11,
	  "name": "Cheese Store",
	  "max": 1,
	  "model": "tower_red.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 10
	},
	{
	  "id": 71,
	  "name": "Cheese Store",
	  "max": 1,
	  "model": "tower_yellow.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 10
	},
	{
	  "id": 42,
	  "name": "Cream Store",
	  "max": 1,
	  "model": "fuel_depot_blue.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 10
	},
	{
	  "id": 102,
	  "name": "Cream Store",
	  "max": 1,
	  "model": "fuel_depot_green.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 10
	},
	{
	  "id": 12,
	  "name": "Cream Store",
	  "max": 1,
	  "model": "fuel_depot_red.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 10
	},
	{
	  "id": 72,
	  "name": "Cream Store",
	  "max": 1,
	  "model": "fuel_depot_yellow.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 10
	},
	{
	  "id": 43,
	  "name": "Icecream Store",
	  "max": 1,
	  "model": "fuel_depot_blue.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 10
	},
	{
	  "id": 103,
	  "name": "Icecream Store",
	  "max": 1,
	  "model": "fuel_depot_green.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 10
	},
	{
	  "id": 13,
	  "name": "Icecream Store",
	  "max": 1,
	  "model": "fuel_depot_red.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 10
	},
	{
	  "id": 73,
	  "name": "Icecream Store",
	  "max": 1,
	  "model": "fuel_depot_yellow.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 10
	},
	{
	  "id": 44,
	  "name": "Leather Store",
	  "max": 1,
	  "model": "tower_blue.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 10
	},
	{
	  "id": 104,
	  "name": "Leather Store",
	  "max": 1,
	  "model": "tower_green.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 10
	},
	{
	  "id": 14,
	  "name": "Leather Store",
	  "max": 1,
	  "model": "tower_red.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 10
	},
	{
	  "id": 74,
	  "name": "Leather Store",
	  "max": 1,
	  "model": "tower_yellow.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 10
	},
	{
	  "id": 45,
	  "name": "Manure Store",
	  "max": 1,
	  "model": "fuel_depot_blue.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 10
	},
	{
	  "id": 105,
	  "name": "Manure Store",
	  "max": 1,
	  "model": "fuel_depot_green.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 10
	},
	{
	  "id": 15,
	  "name": "Manure Store",
	  "max": 1,
	  "model": "fuel_depot_red.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 10
	},
	{
	  "id": 75,
	  "name": "Manure Store",
	  "max": 1,
	  "model": "fuel_depot_yellow.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 10
	},
	{
	  "id": 46,
	  "name": "Milk Store",
	  "max": 1,
	  "model": "fuel_depot_blue.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 10
	},
	{
	  "id": 106,
	  "name": "Milk Store",
	  "max": 1,
	  "model": "fuel_depot_green.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 10
	},
	{
	  "id": 16,
	  "name": "Milk Store",
	  "max": 1,
	  "model": "fuel_depot_red.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 10
	},
	{
	  "id": 76,
	  "name": "Milk Store",
	  "max": 1,
	  "model": "fuel_depot_yellow.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 10
	},
	{
	  "id": 36,
	  "name": "Construction",
	  "max": 1,
	  "model": "construction_blue.tscn",
	  "cost": 10,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 96,
	  "name": "Construction",
	  "max": 1,
	  "model": "construction_green.tscn",
	  "cost": 10,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 6,
	  "name": "Construction",
	  "max": 1,
	  "model": "construction_red.tscn",
	  "cost": 10,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 66,
	  "name": "Construction",
	  "max": 1,
	  "model": "construction_yellow.tscn",
	  "cost": 10,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 50,
	  "name": "Habitation",
	  "max": 1,
	  "model": "altar_blue.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 110,
	  "name": "Habitation",
	  "max": 1,
	  "model": "altar_green.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 20,
	  "name": "Habitation",
	  "max": 1,
	  "model": "altar_red.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 80,
	  "name": "Habitation",
	  "max": 1,
	  "model": "altar_yellow.tscn",
	  "cost": 5,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 34,
	  "name": "Catalog Store",
	  "max": 1,
	  "model": "altar_2_blue.tscn",
	  "cost": 10,
	  "cashprod": 10,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 94,
	  "name": "Catalog Store",
	  "max": 1,
	  "model": "altar_2_green.tscn",
	  "cost": 10,
	  "cashprod": 10,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 4,
	  "name": "Catalog Store",
	  "max": 1,
	  "model": "altar_2_red.tscn",
	  "cost": 10,
	  "cashprod": 10,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 64,
	  "name": "Catalog Store",
	  "max": 1,
	  "model": "altar_2_yellow.tscn",
	  "cost": 10,
	  "cashprod": 10,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 37,
	  "name": "Veterinary",
	  "max": 1,
	  "model": "command_center_1_blue.tscn",
	  "cost": 10,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 97,
	  "name": "Veterinary",
	  "max": 1,
	  "model": "command_center_1_green.tscn",
	  "cost": 10,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 7,
	  "name": "Veterinary",
	  "max": 1,
	  "model": "command_center_1_red.tscn",
	  "cost": 10,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 67,
	  "name": "Veterinary",
	  "max": 1,
	  "model": "command_center_1_yellow.tscn",
	  "cost": 10,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 51,
	  "name": "Cheese Lab",
	  "max": 1,
	  "model": "factory_2_blue.tscn",
	  "cost": 10,
	  "cashprod": 4,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 111,
	  "name": "Cheese Lab",
	  "max": 1,
	  "model": "factory_2_green.tscn",
	  "cost": 10,
	  "cashprod": 4,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 21,
	  "name": "Cheese Lab",
	  "max": 1,
	  "model": "factory_2_red.tscn",
	  "cost": 10,
	  "cashprod": 4,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 81,
	  "name": "Cheese Lab",
	  "max": 1,
	  "model": "factory_2_yellow.tscn",
	  "cost": 10,
	  "cashprod": 4,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 52,
	  "name": "Sausage Lab",
	  "max": 1,
	  "model": "factory_2_blue.tscn",
	  "cost": 10,
	  "cashprod": 4,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 112,
	  "name": "Sausage Lab",
	  "max": 1,
	  "model": "factory_2_green.tscn",
	  "cost": 10,
	  "cashprod": 4,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 22,
	  "name": "Sausage Lab",
	  "max": 1,
	  "model": "factory_2_red.tscn",
	  "cost": 10,
	  "cashprod": 4,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 82,
	  "name": "Sausage Lab",
	  "max": 1,
	  "model": "factory_2_yellow.tscn",
	  "cost": 10,
	  "cashprod": 4,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 54,
	  "name": "Law Office",
	  "max": 1,
	  "model": "command_center_3_blue.tscn",
	  "cost": 15,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 114,
	  "name": "Law Office",
	  "max": 1,
	  "model": "command_center_3_green.tscn",
	  "cost": 15,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 24,
	  "name": "Law Office",
	  "max": 1,
	  "model": "command_center_3_red.tscn",
	  "cost": 15,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	},
	{
	  "id": 84,
	  "name": "Law Office",
	  "max": 1,
	  "model": "command_center_3_yellow.tscn",
	  "cost": 15,
	  "cashprod": 0,
	  "energyprod": 0,
	  "energyreq": 1,
	  "output": 0,
	  "storage": 0
	}
	]				#{  "id": 31, "name": "Start Up", "max": 1, "model": "crystal_farm_blue.tscn", "cost": 2,"cashprod": 2, "energyprod": 2, "energyreq": 0, "output": 0, "storage": 0}
# tModules = Data for each individual Building on the Board - {cost = 0, cashprod = 0, energyprod = 0, energyreq = 0, output = 0, storage = 0, online = "N", sick = "N"}
var tModules = [
	[{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}],
	[{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}],
	[{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}],
	[{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}],
	[{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}],
	[{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}],
	[{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}],
	[{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}],
	[{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}],
	[{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}],
	[{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}],
	[{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}],
	[{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}],
	[{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}],
	[{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}],
	[{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}],
	[{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}]]			# [x][y]{cost = 0, cashprod = 0, energyprod = 0, energyreq = 0, output = 0, storage = 0, online = "N", sick = "N"}
# tNumDisease = Current Number of Diseases for each Player [1-4] = player number
var tNumDisease = [0, 0, 0, 0, 0]
# tNumModules = Current Count of Placed Modules for each Player [1 - 4] = player number
var tNumModules = [0, 0, 0, 0, 0]
# tNumRolls = Current Number of Rolls for each Player [1 - 4] = player number
var tNumRolls = [0, 0, 0, 0, 0]
# tOfflineIcons = Godot ID of Offline Icon at Location
var tOfflineIcons = [
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]]			# [x][y] boolean
# tOOP = Order of Play [1 - 4] = {user = tUsers[x].id, playnum = tUsers[x].PlayerNumber, name = tUsers[x].name}
var tOOP = [
	{"user" = -1, "playnum" = -1, "name" = ""},
	{"user" = -1, "playnum" = -1, "name" = ""},
	{"user" = -1, "playnum" = -1, "name" = ""},
	{"user" = -1, "playnum" = -1, "name" = ""},
	{"user" = -1, "playnum" = -1, "name" = ""},
	]
# tPastureDome = Does Player have a Pasture Dome? [1 - 4] = true or false
var tPastureDome = [false, false, false, false, false]
# tPlayOn = Does Player want to Play On if NO WINNER? [1 - 4] = [0 = No Response, 1 = No, 2 = Yes]
var tPlayOn = [0, 0, 0, 0, 0]
# tPortal = Does Player have a Portal? [1 - 4] = true or false
var tPortal = [false, false, false, false, false]
# tPrices = Current Commodity Prices 0 = BEEF ... 7 = MILK
var tPrices = [0, 0, 0, 0, 0, 0, 0, 0]
# tREPrices = Commodity Price Change following Random Event for each Player [1-4] = {"beef": 0, "butter": 0, "cheese": 0, "cream": 0, "icecream": 0, "leather": 0, "manure": 0, "milk": 0}
var tREPrices = [
	{"beef": 0, "butter": 0, "cheese": 0, "cream": 0, "icecream": 0, "leather": 0, "manure": 0, "milk": 0},
	{"beef": 0, "butter": 0, "cheese": 0, "cream": 0, "icecream": 0, "leather": 0, "manure": 0, "milk": 0},
	{"beef": 0, "butter": 0, "cheese": 0, "cream": 0, "icecream": 0, "leather": 0, "manure": 0, "milk": 0},
	{"beef": 0, "butter": 0, "cheese": 0, "cream": 0, "icecream": 0, "leather": 0, "manure": 0, "milk": 0},
	{"beef": 0, "butter": 0, "cheese": 0, "cream": 0, "icecream": 0, "leather": 0, "manure": 0, "milk": 0}
	]
# tREStorage = Storage for each Player following Random Event [1 - 4] = {"beef": 0, "butter": 0, "cheese": 0, "cream": 0, "icecream": 0, "leather": 0, "manure": 0, "milk": 0}
var tREStorage = [
	{"beef": 0, "butter": 0, "cheese": 0, "cream": 0, "icecream": 0, "leather": 0, "manure": 0, "milk": 0},
	{"beef": 0, "butter": 0, "cheese": 0, "cream": 0, "icecream": 0, "leather": 0, "manure": 0, "milk": 0},
	{"beef": 0, "butter": 0, "cheese": 0, "cream": 0, "icecream": 0, "leather": 0, "manure": 0, "milk": 0},
	{"beef": 0, "butter": 0, "cheese": 0, "cream": 0, "icecream": 0, "leather": 0, "manure": 0, "milk": 0},
	{"beef": 0, "butter": 0, "cheese": 0, "cream": 0, "icecream": 0, "leather": 0, "manure": 0, "milk": 0}
	]
# tSausageLab = Does Player have a Sausage Lab? [1 - 4] = true or false
var tSausageLab = [false, false, false, false, false]
# tLawOffice = Does Player have a Law Office? [1 - 4] = true or false
var tLawOffice = [false, false, false, false, false]
# tSickIconb = Godot ID of Sick Icon at Location
var tSickIcons = [
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]]			# [x][y] boolean
# tStorage = Current Storage for each Player [1 - 4] = {"beef": 0, "butter": 0, "cheese": 0, "cream": 0, "icecream": 0, "leather": 0, "manure": 0, "milk": 0}
var tStorage = [
	{"beef": 0, "butter": 0, "cheese": 0, "cream": 0, "icecream": 0, "leather": 0, "manure": 0, "milk": 0},
	{"beef": 0, "butter": 0, "cheese": 0, "cream": 0, "icecream": 0, "leather": 0, "manure": 0, "milk": 0},
	{"beef": 0, "butter": 0, "cheese": 0, "cream": 0, "icecream": 0, "leather": 0, "manure": 0, "milk": 0},
	{"beef": 0, "butter": 0, "cheese": 0, "cream": 0, "icecream": 0, "leather": 0, "manure": 0, "milk": 0},
	{"beef": 0, "butter": 0, "cheese": 0, "cream": 0, "icecream": 0, "leather": 0, "manure": 0, "milk": 0}
	]			#{"beef": 0, "butter": 0, "cheese": 0, "cream": 0, "icecream": 0, "leather": 0, "manure": 0, "milk": 0} for each player [1 - 4]
# tWords = Numbers 1 - 10 as Words
var tWords = [
	"Zero (0)",
	"One (1)",
	"Two (2)",
	"Three (3)",
	"Four (4)",
	"Five (5)",
	"Six (6)",
	"Seven (7)",
	"Eight (8)",
	"Nine (9)",
	"Ten (10)"
	]
# iCurPlay = Current Player
var iCurPlay = 0
# iD = Used in _process to restrict to approx. 30 FPS
var iD = 0
# iMaxRounds = Maximum Number of Rounds
var iMaxRounds = 15
# iRound = Current Round
var iRound = 0
# iSick = Counter for Number of Sick Barns
var iSick = 0
# dragLoc = Drag Location - used when dragging & dropping
var dragLoc = Vector2()
# hover = Link to Hover Popup for UI
var hover
# hoverText = Link to Text in Hover Popup for UI
var hoverTxt

func myDebug(Dict = {}):
	var time = Time.get_time_dict_from_system()
	var time_return = str("%02d" % time.hour) + ":" + str("%02d" % time.minute) + ":" + str("%02d" % time.second)
	var frame = get_stack()[1]
	var sTxt = time_return + ": " + "    At: " + frame.source.get_file() + ":" + str(frame.line) + ":" + frame.function + "()"
	print(sTxt)
	print(time_return + ":     Client ID: " + str(GDSync.get_client_id()))
	var sTxt1 = ""

	if not Dict.is_empty():
		for x in Dict:
			sTxt1 = time_return + ": " + "        " + x + ": " + str(Dict[x])
			print(sTxt1)

func _ready():
	hover = get_tree().get_root().get_node("Spatial/CanvasLayer/UI/InGame/VBoxContainer/Main/Label/HBoxContainer/PanelContainer2")
	hoverTxt = get_tree().get_root().get_node("Spatial/CanvasLayer/UI/InGame/VBoxContainer/Main/Label/HBoxContainer/PanelContainer2/Messages/txtMessages")
	Globals.music.shuffle()
	var curMusic = Globals.music[randi() % 20]
	var audio_stream = load("res://Assets/Sounds/Music/" + curMusic)
	$Music.stream = audio_stream
	$Music.play()
	GDSync.expose_func(updateiCurPlay)
	GDSync.expose_func(updateiWait)
	GDSync.expose_func(startUp)
	GDSync.expose_func(getBoard)
	GDSync.expose_func(updateMaterials)
	GDSync.expose_func(updateNumModules)
	GDSync.expose_func(updateNumDisease)
	GDSync.expose_func(updateModules)
	GDSync.expose_func(updateModels)
	GDSync.expose_func(updateBuildings)
	GDSync.expose_var(self, "tBoard")
	GDSync.expose_var(self, "tBoardLoc")
	popup.visible = false
	inGame.visible = true
	help.visible = false
	UniversalSettings.visible = false
	UniversalSettings.reparent(ui)
	get_tree().set_auto_accept_quit(false)
	_started.call_deferred()

func _notification(what):
	if Sfx != null:
		Sfx.stream = Globals.sfx_click
		Sfx.play()

	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		btnOK.visible = false
		popup.visible = true

func _started():
	Globals.iMyID = GDSync.get_client_id()
	Globals.bStarted = true

	if GDSync.is_host():
		Globals.iWait = Messages.Msg.ORDER_OF_PLAY
		GDSync.call_func(updateiWait, [Globals.iWait])

func startUp():
	for x in tOOP:
		if x.id == Globals.iMyID:
			Globals.iMyPN = x.playnum
			Globals.sMyName = x.name
	
	inGame.lblP1.set_text(tOOP[1].name)
	inGame.lblP2.set_text(tOOP[2].name)
	inGame.lblScoreP1.set_text("$100")
	inGame.lblScoreP2.set_text("$100")

	if GDSync.get_lobby_player_limit() > 2:
		inGame.lblP3.set_text(tOOP[3].name)
		inGame.lblScoreP3.set_text("$100")

		if GDSync.get_lobby_player_limit() > 3:
			inGame.set_text(tOOP[4].name)
			inGame.lblScoreP4.set_text("$100")
		else:
			inGame.lblP4.visible = false
			inGame.lblScoreP4.visible = false
	else:
		inGame.lblP3.visible = false
		inGame.lblScoreP3.visible = false
		inGame.lblP4.visible = false
		inGame.lblScoreP4.visible = false

	inGame.lblRounds.set_text("15")

func getBoard():
	var nodes = $Board.get_children()

	for n in nodes:
		for x in range(1, 17):
			for y in range(1, 13):
				if snapped(n.position.x, 0.01) == snapped(tBoardLoc[x][y][0], 0.01) and snapped(n.position.z, 0.01) == snapped(tBoardLoc[x][y][1], 0.01):
					tBoardModel[x][y] = n.name

func _process(delta):
	iD += delta

	if iD > 0.033:
		iD = 0.0

		if Globals.bStarted and iRound <= iMaxRounds and not TTS.is_speaking():
			match Globals.iWait:
				Messages.Msg.ORDER_OF_PLAY:
					Globals.iWait = Messages.Msg.WAIT_ORDER_OF_PLAY

					if GDSync.is_host():
						Functions.getOrderOfPlay()
						startUp()
						GDSync.call_func(startUp)
						Globals.iWait = Messages.Msg.CREATE_BOARD
						GDSync.call_func(updateiWait, [Globals.iWait])
				Messages.Msg.CREATE_BOARD:
					Globals.iWait = Messages.Msg.WAIT_CREATE_BOARD

					if GDSync.is_host():
						Functions.buildBoard()
						GDSync.sync_var(self, "tBoard", true)
						GDSync.sync_var(self, "tBoardLoc", true)
						iCurPlay = 1
						GDSync.call_func(updateiCurPlay, [iCurPlay])
						Functions.createBoard()
						Globals.iWait = Messages.Msg.STARTUP
						GDSync.call_func(updateiWait, [Globals.iWait])
				Messages.Msg.STARTUP:
					Globals.iWait = Messages.Msg.WAIT_PLACE_STARTUP
					GDSync.call_func(getBoard)
					Functions.placeStartup()
				Messages.Msg.PLACE_STARTUP:
					Globals.iWait = Messages.Msg.WAIT_PLACE_STARTUP
					Functions.placeStartup()
				Messages.Msg.STARTUP_PLACED:
					Globals.iWait = Messages.Msg.WAIT_PLACE_STARTUP

					if iCurPlay == Globals.iMyPN:
						iCurPlay += 1
						GDSync.call_func(updateiCurPlay, [iCurPlay])

					if iCurPlay <= GDSync.get_lobby_player_limit():
						Globals.iWait = Messages.Msg.PLACE_STARTUP
						GDSync.call_func(updateiWait, [Globals.iWait])
					else:
						updateMaterials()
						GDSync.call_func(updateMaterials)
						iCurPlay = 1
						GDSync.call_func(updateiCurPlay, [iCurPlay])
						Globals.iWait = Messages.Msg.CONSTRUCTION
						GDSync.call_func(updateiWait, [Globals.iWait])
				Messages.Msg.CONSTRUCTION:
					Globals.iWait = Messages.Msg.WAIT_CONSTRUCTION
					Functions.construction()
				Messages.Msg.MODULE_MOVED:
					if iCurPlay == Globals.iMyPN:
						iCurPlay += 1
						GDSync.call_func(updateiCurPlay, [iCurPlay])

					if iCurPlay <= GDSync.get_lobby_player_limit():
						Globals.iWait = Messages.Msg.CONSTRUCTION
						GDSync.call_func(updateiWait, [Globals.iWait])
					else:
						iCurPlay = 1
						GDSync.call_func(updateiCurPlay, [iCurPlay])
						Globals.iModules = 0
						Globals.iWait = Messages.Msg.PLACE_MODULES
						GDSync.call_func(updateiWait, [Globals.iWait])
				Messages.Msg.PLACE_MODULES:
					Globals.iWait = Messages.Msg.WAIT_PLACE_MODULES
					Functions.placeModules(true)
				Messages.Msg.MODULES_PLACED:
					if iCurPlay == Globals.iMyPN:
						iCurPlay += 1
						GDSync.call_func(updateiCurPlay, [iCurPlay])

					if iCurPlay <= GDSync.get_lobby_player_limit():
						Globals.iWait = Messages.Msg.PLACE_MODULES
						GDSync.call_func(updateiWait, [Globals.iWait])
					else:
						iCurPlay = 1
						GDSync.call_func(updateiCurPlay, [iCurPlay])
						Globals.iWait = Messages.Msg.DISEASE
						GDSync.call_func(updateiWait, [Globals.iWait])
				Messages.Msg.DISEASE:
					Globals.iWait = Messages.Msg.WAIT_DISEASE
					Globals.selObject = null
					Functions.disease()
				Messages.Msg.DISEASE_DONE:
					if iCurPlay == Globals.iMyPN:
						iCurPlay += 1
						GDSync.call_func(updateiCurPlay, [iCurPlay])

					if iCurPlay <= GDSync.get_lobby_player_limit():
						Globals.iWait = Messages.Msg.DISEASE
						GDSync.call_func(updateiWait, [Globals.iWait])
					else:
						iCurPlay = 1
						GDSync.call_func(updateiCurPlay, [iCurPlay])
						Globals.iWait = Messages.Msg.ENERGY
						GDSync.call_func(updateiWait, [Globals.iWait])
				Messages.Msg.ENERGY:
					Globals.iWait = Messages.Msg.WAIT_ENERGY
					Functions.energy()
				Messages.Msg.ENERGY_DONE:
					if iCurPlay == Globals.iMyPN:
						iCurPlay += 1
						GDSync.call_func(updateiCurPlay, [iCurPlay])

					if iCurPlay <= GDSync.get_lobby_player_limit():
						Globals.iWait = Messages.Msg.ENERGY
						GDSync.call_func(updateiWait, [Globals.iWait])
					else:
						iCurPlay = 1
						GDSync.call_func(updateiCurPlay, [iCurPlay])
						Globals.iWait = Messages.Msg.PRODUCTION
						GDSync.call_func(updateiWait, [Globals.iWait])
				Messages.Msg.PRODUCTION:
					Globals.iWait = Messages.Msg.WAIT_PRODUCTION
					Functions.production()
				Messages.Msg.PRODUCTION_DONE:
					if iCurPlay == Globals.iMyPN:
						iCurPlay += 1
						GDSync.call_func(updateiCurPlay, [iCurPlay])

					if iCurPlay <= GDSync.get_lobby_player_limit():
						Globals.iWait = Messages.Msg.PRODUCTION
						GDSync.call_func(updateiWait, [Globals.iWait])
					else:
						iCurPlay = 1
						GDSync.call_func(updateiCurPlay, [iCurPlay])
						Globals.iWait = Messages.Msg.RANDOM_EVENT
						GDSync.call_func(updateiWait, [Globals.iWait])
				Messages.Msg.RANDOM_EVENT:
					Globals.iWait = Messages.Msg.WAIT_RANDOM_EVENT
					Functions.randomEvent()
				Messages.Msg.RANDOM_EVENT_DONE:
					if iCurPlay == Globals.iMyPN:
						iCurPlay += 1
						GDSync.call_func(updateiCurPlay, [iCurPlay])

					if iCurPlay <= GDSync.get_lobby_player_limit():
						Globals.iWait = Messages.Msg.RANDOM_EVENT
						GDSync.call_func(updateiWait, [Globals.iWait])
					else:
						iCurPlay = 1
						GDSync.call_func(updateiCurPlay, [iCurPlay])
						Globals.iWait = Messages.Msg.GIFT_BOXES
						GDSync.call_func(updateiWait, [Globals.iWait])
				Messages.Msg.GIFT_BOXES:
					Globals.iWait = Messages.Msg.WAIT_GIFT_BOXES
					Functions.giftBoxes()
				Messages.Msg.GIFT_BOXES_DONE:
					if iCurPlay == Globals.iMyPN:
						iCurPlay += 1
						GDSync.call_func(updateiCurPlay, [iCurPlay])

					if iCurPlay <= GDSync.get_lobby_player_limit():
						Globals.iWait = Messages.Msg.GIFT_BOXES
						GDSync.call_func(updateiWait, [Globals.iWait])
					else:
						iCurPlay = 1
						GDSync.call_func(updateiCurPlay, [iCurPlay])
						Globals.iWait = Messages.Msg.COMMODITY_PRICES
						GDSync.call_func(updateiWait, [Globals.iWait])
				Messages.Msg.COMMODITY_PRICES:
					Globals.iWait = Messages.Msg.WAIT_COMMODITIES

					if iCurPlay == 1:
						Functions.setCommodityPrices()

					Globals.iCommodityCount = 1
					Functions.commodityPrices()
				Messages.Msg.COMMODITY_PRICES_DONE:
					if iCurPlay == Globals.iMyPN:
						iCurPlay += 1
						GDSync.call_func(updateiCurPlay, [iCurPlay])

					if iCurPlay <= GDSync.get_lobby_player_limit():
						Globals.iWait = Messages.Msg.COMMODITY_PRICES
						GDSync.call_func(updateiWait, [Globals.iWait])
					else:
						iCurPlay = 1
						GDSync.call_func(updateiCurPlay, [iCurPlay])
						Globals.iWait = Messages.Msg.OTHER_INCOME
						GDSync.call_func(updateiWait, [Globals.iWait])
				Messages.Msg.OTHER_INCOME:
					Globals.iWait = Messages.Msg.WAIT_OTHER_INCOME
					otherIncome()
				Messages.Msg.OTHER_INCOME_DONE:
					if iCurPlay == Globals.iMyPN:
						iCurPlay += 1
						GDSync.call_func(updateiCurPlay, [iCurPlay])

					if iCurPlay <= GDSync.get_lobby_player_limit():
						Globals.iWait = Messages.Msg.OTHER_INCOME
						GDSync.call_func(updateiWait, [Globals.iWait])
					else:
						iCurPlay = 1
						GDSync.call_func(updateiCurPlay, [iCurPlay])
						Globals.iWait = Messages.Msg.LAW_OFFICE
						GDSync.call_func(updateiWait, [Globals.iWait])
				Messages.Msg.LAW_OFFICE:
					Globals.iWait = Messages.Msg.WAIT_LAW_OFFICE
					Functions.lawOffice()
				Messages.Msg.LAW_OFFICE_DONE:
					if iCurPlay == Globals.iMyPN:
						iCurPlay += 1
						GDSync.call_func(updateiCurPlay, [iCurPlay])

					if iCurPlay <= GDSync.get_lobby_player_limit():
						Globals.iWait = Messages.Msg.LAW_OFFICE
						GDSync.call_func(updateiWait, [Globals.iWait])
					else:
						iCurPlay = 1
						GDSync.call_func(updateiCurPlay, [iCurPlay])
						Globals.iWait = Messages.Msg.VETERINARY
						GDSync.call_func(updateiWait, [Globals.iWait])
				Messages.Msg.VETERINARY:
					Globals.iWait = Messages.Msg.WAIT_VETERINARY
					Functions.veterinary()
				Messages.Msg.VETERINARY_DONE:
					if iCurPlay == Globals.iMyPN:
						iCurPlay += 1
						GDSync.call_func(updateiCurPlay, [iCurPlay])

					if iCurPlay <= GDSync.get_lobby_player_limit():
						Globals.iWait = Messages.Msg.VETERINARY
						GDSync.call_func(updateiWait, [Globals.iWait])
					else:
						iCurPlay = 1
						GDSync.call_func(updateiCurPlay, [iCurPlay])
						Globals.iWait = Messages.Msg.RESET_COMMODITIES
						GDSync.call_func(updateiWait, [Globals.iWait])
				Messages.Msg.RESET_COMMODITIES:
					Globals.iWait = Messages.Msg.WAIT_RESET_COMMODITIES
					Functions.resetCommodities()
				Messages.Msg.RESET_COMMODITIES_DONE:
					if iCurPlay == Globals.iMyPN:
						iCurPlay += 1
						GDSync.call_func(updateiCurPlay, [iCurPlay])

					if iCurPlay <= GDSync.get_lobby_player_limit():
						Globals.iWait = Messages.Msg.RESET_COMMODITIES
						GDSync.call_func(updateiWait, [Globals.iWait])
					else:
						iCurPlay = 1
						GDSync.call_func(updateiCurPlay, [iCurPlay])
						Globals.iWait = Messages.Msg.END_OF_ROUND
						GDSync.call_func(updateiWait, [Globals.iWait])
				Messages.Msg.END_OF_ROUND:
					Globals.iWait = Messages.Msg.WAIT_END_OF_ROUND
					Functions.endOfRound()
				Messages.Msg.END_OF_ROUND_DONE:
					if iCurPlay == Globals.iMyPN:
						iCurPlay += 1
						GDSync.call_func(updateiCurPlay, [iCurPlay])

					if iCurPlay <= GDSync.get_lobby_player_limit():
						Globals.iWait = Messages.Msg.END_OF_ROUND
						GDSync.call_func(updateiWait, [Globals.iWait])
					else:
						inGame.lblRoundsRem.text = str(iMaxRounds - iRound)
						iCurPlay = 1
						GDSync.call_func(updateiCurPlay, [iCurPlay])

						if iRound == iMaxRounds:
							Globals.iWait = Messages.Msg.END_OF_GAME
							GDSync.call_func(updateiWait, [Globals.iWait])
						else:
							Globals.iWait = Messages.Msg.CONSTRUCTION
							GDSync.call_func(updateiWait, [Globals.iWait])
				Messages.Msg.END_OF_GAME:
					if GDSync.is_host():
						var iCount = tBank.count(tBank.max())

						if iCount > 1:
							var iC = 0

							for x in tBank:
								if x == tBank.max():
									tPlayOn[iC] = 0
								else:
									tPlayOn[iC] = 2

								iC += 1

							Globals.iWait = Messages.Msg.TIED_GAME
							GDSync.call_func(updateiWait, [Globals.iWait])
							Functions.tiedGame(iCount)
						else:
							Globals.iWait = Messages.Msg.WAIT_END_OF_GAME
							GDSync.call_func(updateiWait, [Globals.iWait])
							Functions.endOfGame()
				Messages.Msg.WAIT_TIED_GAME:
					var iC = 0
					var iPlayOnYes = 0
					var iPlayOnNo = 0

					for x in tPlayOn:
						if x > 0:
							iC += 1

							if x == 2:
								iPlayOnYes += 1
							elif x == 1:
								iPlayOnNo += 1

					if iC == GDSync.get_lobby_player_limit():
						if iPlayOnYes > iPlayOnNo:
							Globals.iWait = Messages.Msg.PLAY_ON
							GDSync.call_func(updateiWait, [Globals.iWait])
						else:
							Globals.iWait = Messages.Msg.WAIT_END_OF_GAME
							GDSync.call_func(updateiWait, [Globals.iWait])
							Functions.endOfGame()
				Messages.Msg.PLAY_ON:
					iMaxRounds += 3
					iCurPlay = 1
					GDSync.call_func(updateiCurPlay, [iCurPlay])
					Globals.iWait = Messages.Msg.CONSTRUCTION
					GDSync.call_func(updateiWait, [Globals.iWait])
				Messages.Msg.QUIT_GAME:
					Functions.backToLobby()

func updateMaterials():
	var b = $Board.get_children()

	for x in range(1, 17):
		for y in range(1, 13):
			for n in b:
				if tBoardModel[x][y] == n.name:
					if tBoard[x][y] == 2 or tBoard[x][y] == 3 or tBoard[x][y] == 5:
						n.position.y = -0.005
					else:
						n.position.y = 0.0

				break

	for x in $Board.get_children():
		var sMesh = x.get_node("StaticMesh")
		var iC = sMesh.get_surface_override_material_count()
		sMesh.set_surface_override_material(0, Globals.mDirt)

		if iC > 1:
			var sTmp = sMesh.get_surface_override_material(1).resource_path

			if not sTmp.contains("grass"):
				sMesh.set_surface_override_material(1, Globals.mDirt)

func updateiCurPlay(inCurPlay):
	iCurPlay = inCurPlay

func updateiWait(inWait):
	Globals.iWait = inWait

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_F1 and not event.is_echo() and event.is_pressed():
			Sfx.stream = Globals.sfx_click
			Sfx.play()

			if UniversalSettings.visible:
				UniversalSettings.quit_menu()

			if help.visible:
				help.visible = false
			else:
				help.visible = true
		elif event.keycode == KEY_F2 and not event.is_echo() and event.is_pressed():
			Sfx.stream = Globals.sfx_click
			Sfx.play()

			if help.visible:
				help.visible = false

			if UniversalSettings.visible:
				UniversalSettings.quit_menu()
			else:
				UniversalSettings.show_screen()
		elif event.keycode == KEY_F3 and not event.is_echo() and event.is_pressed():
			Sfx.stream = Globals.sfx_click
			Sfx.play()

			if TTS.is_speaking():
				TTS.stop()
		elif event.keycode == KEY_F12 and not event.is_echo() and event.is_pressed():
			Sfx.stream = Globals.sfx_click
			Sfx.play()
			btnOK.visible = false
			popup.visible = true
	elif event is InputEventMouseMotion:
		if iCurPlay == Globals.iMyPN and Globals.bDrag:
			var camera = get_tree().get_root().get_node("Spatial/Camera")
			var dropPlane = Plane(Vector3(0, 1, 0), 2)
			var rayLength = 1000
			var mousePos = get_viewport().get_mouse_position()
			var from = camera.project_ray_origin(mousePos)
			var to = from + camera.project_ray_normal(mousePos) * rayLength
			var cursorPos = dropPlane.intersects_ray(from, to)
			dragLoc = cursorPos

			if dragLoc.y < 2:
				dragLoc.y = 2

			Globals.dragObject.set_position(dragLoc)

			if Globals.iWait == Messages.Msg.WAIT_PLACE_STARTUP:
				if dragLoc.x >= -40 and dragLoc.x < 18.175 and dragLoc.z <= 40 and dragLoc.z >-3.635:
					if Globals.iPrevArea != 1:
						Functions.moveArea(Globals.iPrevArea, false)
						Functions.moveArea(1, true)
						Globals.iPrevArea = 1
				elif dragLoc.x >= 18.175 and dragLoc.x < 76.335 and dragLoc.z <= -3.635 and dragLoc.z >-47.25:
					if Globals.iPrevArea != 4:
						Functions.moveArea(Globals.iPrevArea, false)
						Functions.moveArea(4, true)
						Globals.iPrevArea = 4
				elif dragLoc.x >= -40 and dragLoc.x < 18.175 and dragLoc.z <= -3.635 and dragLoc.z >-47.25:
					if Globals.iPrevArea != 3:
						Functions.moveArea(Globals.iPrevArea, false)
						Functions.moveArea(3, true)
						Globals.iPrevArea = 3
				elif dragLoc.x >= 18.175 and dragLoc.x < 76.335 and dragLoc.z <= 40 and dragLoc.z >-3.635:
					if Globals.iPrevArea != 2:
						Functions.moveArea(Globals.iPrevArea, false)
						Functions.moveArea(2, true)
						Globals.iPrevArea = 2
	elif event is InputEventMouseButton:
		if not event.pressed:
			if iCurPlay == Globals.iMyPN and Globals.bDrag:
				# {"bOn": false, "x": 0, "y": 0}
				var result = Functions.checkHitLocation(dragLoc.x, dragLoc.y, dragLoc.z)

				if result.bOn == 2:
					if Globals.iWait == Messages.Msg.WAIT_PLACE_STARTUP:
						Functions.moveArea(Globals.iPrevArea, false)
						Globals.iPrevArea = 0
						Functions.startUpPlaced(result)
					elif Globals.iWait == Messages.Msg.WAIT_MOVE_MODULES:
						Functions.modulePlaced(result, false)
					elif Globals.iWait == Messages.Msg.WAIT_PLACE_MODULES or Globals.iWait == Messages.Msg.WAIT_PLACE_MORE_MODULES:
						Functions.modulePlaced(result, true)
				else:
					if Globals.iWait == Messages.Msg.PLACE_STARTUP or Globals.iWait == Messages.Msg.WAIT_PLACE_MODULES \
						or Globals.iWait == Messages.Msg.WAIT_PLACE_MORE_MODULES:
							if result.bOn == 1:
								var sTxt = ""

								if Globals.iWait == Messages.Msg.PLACE_STARTUP:
									sTxt = "[PLACE STARTUP]"
								else:
									sTxt = "[PLACE MODULES]"
									
								sTxt += "[br]That Location is already taken!.[br]Please try again."
								await(inGame.updateGUI(sTxt))

							inGame.resetDrag()
					else:
						for x in range(1, 17):
							for y in range(1, 13):
								if tBuildings[x][y] == Globals.iCurModDND:
									var xx = tBoardLoc[x][y][0]
									var zz = tBoardLoc[x][y][1]
									Globals.dragObject.position.x = xx
									Globals.dragObject.position.z = zz
									Functions.moveCamera(xx, zz)
									break

						inGame.resetDrag()
			elif Globals.iWait == Messages.Msg.WAIT_DISEASE:
				var result = Functions.checkHitLocation(Globals.selObject.position.x, Globals.selObject.position.y, Globals.selObject.position.z)

				if result.bOn > 0:
					if tBuildings[result.x][result.y] == 30 * Globals.iMyPN - 13 or tBuildings[result.x][result.y] == 30 * Globals.iMyPN - 12:
						if tSickIcons[result.x][result.y] > -1:
							Functions.addIcon(result.x, result.y, 0, -1)
							iSick -= 1
						else:
							Functions.addIcon(result.x, result.y, 1, -1)
							iSick += 1
			elif Globals.iWait == Messages.Msg.WAIT_ENERGY_DEFICIT:
				var result = Functions.checkHitLocation(Globals.selObject.position.x, Globals.selObject.position.y, Globals.selObject.position.z)

				if result.bOn > 0:
					if tBuildings[result.x][result.y] > 30 * Globals.iMyPN - 27 or tBuildings[result.x][result.y] < 30 * Globals.iMyPN - 1:
						if tOfflineIcons[result.x][result.y] > -1:
							Functions.addIcon(result.x, result.y, -1, 0)
						else:
							Functions.addIcon(result.x, result.y, -1, 1)

func _on_btn_yes_pressed() -> void:
	Sfx.stream = Globals.sfx_click
	Sfx.play()

	if Globals.bStarted:
		GDSync.call_func(Functions.playerQuit, [Globals.iMyPN])

	GDSync.quit()

func _on_btn_ok_pressed() -> void:
	pass

func _on_btn_no_pressed() -> void:
	Sfx.stream = Globals.sfx_click
	Sfx.play()
	popup.visible = false

func otherIncome():
	var sT = Messages.Msg2Txt(Globals.iWait)
	myDebug({"iWait": sT})
	var iIncome = 0
	var iSu = 0
	var iCh = 0
	var iSa = 0
	var xx = 0
	var yy = 0

	if iCurPlay == Globals.iMyPN:
		var tNum = Globals.iMyPN * 30 - 29
		var tNum1 = Globals.iMyPN * 30 - 9
		var tNum2 = Globals.iMyPN * 30 - 8

		# 1, 31, 61, 91
		for x in range(1, 17):
			for y in range(1, 13):
				if tBuildings[x][y] == tNum:
					xx = x
					yy = y
					break

		if tModules[xx][yy].online == "Y":
			iSu = tModules[xx][yy].cashprod
			iIncome += iSu

		if tCheeseLab[Globals.iMyPN]:
			# 21, 51, 81, 111
			for x in range(1, 17):
				for y in range(1, 13):
					if tBuildings[x][y] == tNum1:
						xx = x
						yy = y
						break

			if tModules[xx][yy].online == "Y":
				iCh = Globals.tREOther[Globals.iMyPN].labs
				iIncome += iCh

		if tSausageLab[Globals.iMyPN]:
			# 22, 52, 82, 112
			for x in range(1, 17):
				for y in range(1, 13):
					if tBuildings[x][y] == tNum2:
						xx = x
						yy = y
						break

			if tModules[xx][yy].online == "Y":
				iSa = Globals.tREOther[Globals.iMyPN].labs
				iIncome += iSa

		tBank[Globals.iMyPN] += iIncome
		inGame.updateBank(Globals.iMyPN, tBank[Globals.iMyPN])
		GDSync.call_func(inGame.updateBank, [Globals.iMyPN, tBank[Globals.iMyPN]])
		var sTxt = "[OTHER INCOME][br]You made $" + str(iIncome) + ", split as follows:[br]STARTUP: $" + str(iSu) + ",[br]CHEESE LAB: $" + str(iCh) + ",[br]SAUSAGE LAB: $" + str(iSa) + ".[br]Press OK to continue."
		var sTxtSpeech = "[OTHER INCOME]. You made $" + str(iIncome) + ", split as follows. STARTUP. $" + str(iSu) + ", CHEESE LAB. $" + str(iCh) + ", SAUSAGE LAB. $" + str(iSa) + ". Press OK to continue."
		await(inGame.updateGUI(sTxt, [], 1, sTxtSpeech))
		Globals.iWait = Messages.Msg.OTHER_INCOME_OK
	else:
		Functions.otherPlayer("[OTHER INCOME][br]")

func updateNumModules(iIn):
	tNumModules[iCurPlay] += iIn

func updateNumDisease(iIn):
	tNumDisease[iCurPlay] += iIn

func updateModules(x, y, iIn, inVal):
	match iIn:
		0:
			tModules[x][y].sick = inVal
		1:
			tModules[x][y].online = inVal
		2:
			tModules[x][y].storage = inVal
		3:
			tModules[x][y].cost = inVal
		4:
			tModules[x][y].cashprod = inVal
		5:
			tModules[x][y].energyprod = inVal
		6:
			tModules[x][y].energyreq = inVal
		7:
			tModules[x][y].output = inVal
		99:
			tModules[x][y] = {cost = 0, cashprod = 0, energyprod = 0, energyreq = 0, output = 0, storage = 0, online = "N", sick = "N"}

func updateModels(x, y, iIn):
	tModels[x][y] = iIn

func updateBuildings(x, y, iIn):
	tBuildings[x][y] = iIn

func hideHover():
	hover.visible = false

func hoverText(iIn, xx = -1000):
	var sTxt = ""
	var sTxtSpeech = ""

	match(iIn):
		1, 31, 61, 91:
			sTxt = "[b]Start-Up Module[/b][br][br]"
			sTxt += "Allowed = 1[br]Cost = $20[br]Cash Produced = $2[br]Energy Produced = 2[br][br]"
			sTxt += "These must be the first modules built. However, they are quite expensive as they generate their own energy as well as a small amount of $."
			sTxtSpeech = "Start-Up Module. Allowed = 1. Cost = $20. Cash Produced = $2. Energy Produced = 2."
			sTxtSpeech += "These must be the first modules built. However, they are quite expensive as they generate their own energy as well as a small amount of money."
		2, 32, 62, 92:
			sTxt = "[b]Crystal Powerplant Module[/b][br][br]"
			sTxt += "Allowed = 3[br]Cost = $5[br]Energy Produced = 3[br][br]"
			sTxt += "These are the least expensive, and least powerful, energy source."
			sTxtSpeech = "Crystal Powerplant Module. Allowed = 3. Cost = $5. Energy Produced = 3. "
			sTxtSpeech += "These are the least expensive, and least powerful, energy source."
		3, 33, 63, 93:
			sTxt = "[b]Geothermal Powerplant Module[/b][br][br]"
			sTxt += "Allowed = 4[br]Cost = $10[br]Energy Produced = 6[br][br]"
			sTxt += "These produce more energy than the Crystal Powerplant, but can only be built on Geothermal Steam grid units."
			sTxtSpeech = "Geothermal Powerplant Module. Allowed = 4. Cost = $10. Energy Produced = 6. "
			sTxtSpeech += "These produce more energy than the Crystal Powerplant, but can only be built on Geothermal Steam grid units."
		4, 34, 64, 94:
			sTxt = "[b]Catalog Store Module[/b][br][br]"
			sTxt += "Allowed = 1[br]Cost = $10[br]Cash Produced = $10[br]Energy Required = 1[br][br]"
			sTxt += "These allow the selling of tasteful gift boxes of assorted Cheeses, Beef Sausages, and flavourless crackers, usually at higher prices than the Cheese and Beef alone would fetch. A Catalog Store cannot function unless there is a working Portal and at least one stored unit each of Cheese and Beef. Gift boxes are made of one Cheese and one Beef unit each, and usually sell for $10."
			sTxtSpeech = "Catalog Store Module. Allowed = 1. Cost = $10. Cash Produced = $10. Energy Required = 1. "
			sTxtSpeech += "These allow the selling of tasteful gift boxes of assorted Cheeses, Beef Sausages, and flavourless crackers, usually at higher prices than the Cheese and Beef alone would fetch. A Catalog Store cannot function unless there is a working Portal and at least one stored unit each of Cheese and Beef. Gift boxes are made of one Cheese and one Beef unit each, and usually sell for $10."
		5, 35, 65, 95:
			sTxt = "[b]Portal Module[/b][br][br]"
			sTxt += "Allowed = 1[br]Cost = $10[br]Energy Required = 1[br][br]"
			sTxt += "These are required in order to trade with the rest of the Galaxy, via Bos III. Prices of the eight commodities are different each turn and for each colony. Each price is determined by a roll of the dice. The price of Leather can never be higher than 3, and the price of Manure is always 1."
			sTxtSpeech = "Portal Module. Allowed = 1. Cost = $10. Energy Required = 1. "
			sTxtSpeech += "These are required in order to trade with the rest of the Galaxy, via Bos 3. Prices of the eight commodities are different each turn and for each colony. Each price is determined by a roll of the dice. The price of Leather can never be higher than 3, and the price of Manure is always 1."
		6, 36, 66, 96:
			sTxt = "[b]Construction Module[/b][br][br]"
			sTxt += "Allowed = 1[br]Cost = $10[br]Energy Required = 1[br][br]"
			sTxt += "These reduce the cost of new module construction by $1 per module, and allow the movement of one existing module, per turn, to another location. However, this movement is not free, and costs half of the original purchase price (fractions will be dropped)."
			sTxtSpeech = "Construction Module. Allowed = 1. Cost = $10. Energy Required = 1. "
			sTxtSpeech += "These reduce the cost of new module construction by $1 per module, and allow the movement of one existing module, per turn, to another location. However, this movement is not free, and costs half of the original purchase price. Fractions will be dropped."
		7, 37, 67, 97:
			sTxt = "[b]Veterinary Module[/b][br][br]"
			sTxt += "Allowed = 1[br]Cost = $10[br]Energy Required = 1[br][br]"
			sTxt += "These are packed full of the best Nano-Veterinarians in the Galaxy and give the colony a second chance to overcome diseases."
			sTxtSpeech = "Veterinary Module. Allowed = 1. Cost = $10. Energy Required = 1. "
			sTxtSpeech += "These are packed full of the best Nano Veterinarians in the Galaxy and give the colony a second chance to overcome diseases."
		8, 38, 68, 98:
			sTxt = "[b]Hub Module[/b][br][br]"
			sTxt += "Allowed = 4[br]Cost = $5[br][br]"
			sTxt += "These are special connectors. Any module adjacent to a Hub is considered adjacent to any other modules that are also adjacent to the Hub.[br][br]NB: Hub modules use no energy."
			sTxtSpeech = "Hub Module. Allowed = 4. Cost = $5. "
			sTxtSpeech += "These are special connectors. Any module adjacent to a Hub is considered adjacent to any other modules that are also adjacent to the Hub. Nota Bene, Hub modules use no energy."
		9, 39, 69, 99:
			sTxt = "[b]Beef Store Module[/b][br][br]"
			sTxt += "Allowed = 1[br]Cost = $5[br]Energy Required = 1[br][br]"
			sTxt += "These can store up to 10 units of Beef which can be sold, along with the other commodities, at a Portal. All commodity Storage modules must be adjacent to a Processing Plant.[br][br]NB: at the end of each turn, any remaining stored commodities (except Leather and Manure) spoil and must be discarded with the relevant inventory dropping to Zero."
			sTxtSpeech = "Beef Store Module. Allowed = 1. Cost = $5. Energy Required = 1. "
			sTxtSpeech += "These can store up to 10 units of Beef which can be sold, along with the other commodities, at a Portal. All commodity Storage modules must be adjacent to a Processing Plant. Nota Bene, at the end of each turn, any remaining stored commodities, except Leather and Manure, spoil and must be discarded with the relevant inventory dropping to Zero."
		10, 40, 70, 100:
			sTxt = "[b]Butter Store Module[/b][br][br]"
			sTxt += "Allowed = 1[br]Cost = $5[br]Energy Required = 1[br][br]"
			sTxt += "These can store up to 10 units of Butter, which can be sold, along with the other commodities, at a Portal. All commodity Storage modules must be adjacent to a Processing Plant.[br][br]NB: at the end of each turn, any remaining stored commodities (except Leather and Manure) spoil and must be discarded with the relevant inventory dropping to Zero."
			sTxtSpeech = "Butter Store Module. Allowed = 1. Cost = $5. Energy Required = 1. "
			sTxtSpeech += "These can store up to 10 units of Butter which can be sold, along with the other commodities, at a Portal. All commodity Storage modules must be adjacent to a Processing Plant. Nota Bene, at the end of each turn, any remaining stored commodities, except Leather and Manure, spoil and must be discarded with the relevant inventory dropping to Zero."
		11, 41, 71, 101:
			sTxt = "[b]Cheese Store Module[/b][br][br]"
			sTxt += "Allowed = 1[br]Cost = $5[br]Energy Required = 1[br][br]"
			sTxt += "These can store up to 10 units of Cheese which can be sold, along with the other commodities, at a Portal. All commodity Storage modules must be adjacent to a Processing Plant.[br][br]NB: at the end of each turn, any remaining stored commodities (except Leather and Manure) spoil and must be discarded with the relevant inventory dropping to Zero."
			sTxtSpeech = "Cheese Store Module. Allowed = 1. Cost = $5. Energy Required = 1. "
			sTxtSpeech += "These can store up to 10 units of Cheese which can be sold, along with the other commodities, at a Portal. All commodity Storage modules must be adjacent to a Processing Plant. Nota Bene, at the end of each turn, any remaining stored commodities, except Leather and Manure, spoil and must be discarded with the relevant inventory dropping to Zero."
		12, 42, 72, 102:
			sTxt = "[b]Cream Store Module[/b][br][br]"
			sTxt += "Allowed = 1[br]Cost = $5[br]Energy Required = 1[br][br]"
			sTxt += "These can store up to 10 units of Cream, which can be sold, along with the other commodities, at a Portal. All commodity Storage modules must be adjacent to a Processing Plant.[br][br]NB: at the end of each turn, any remaining stored commodities (except Leather and Manure) spoil and must be discarded with the relevant inventory dropping to Zero."
			sTxtSpeech = "Cream Store Module. Allowed = 1. Cost = $5. Energy Required = 1. "
			sTxtSpeech += "These can store up to 10 units of Cream which can be sold, along with the other commodities, at a Portal. All commodity Storage modules must be adjacent to a Processing Plant. Nota Bene, at the end of each turn, any remaining stored commodities, except Leather and Manure, spoil and must be discarded with the relevant inventory dropping to Zero."
		13, 43, 73, 103:
			sTxt = "[b]Ice Cream Store Module[/b][br][br]"
			sTxt += "Allowed = 1[br]Cost = $5[br]Energy Required = 1[br][br]"
			sTxt += "These can store up to 10 units of Ice Cream, which can be sold, along with the other commodities, at a Portal. All commodity Storage modules must be adjacent to a Processing Plant.[br][br]NB: at the end of each turn, any remaining stored commodities (except Leather and Manure) spoil and must be discarded with the relevant inventory dropping to Zero."
			sTxtSpeech = "Ice Cream Store Module. Allowed = 1. Cost = $5. Energy Required = 1. "
			sTxtSpeech += "These can store up to 10 units of Ice Cream which can be sold, along with the other commodities, at a Portal. All commodity Storage modules must be adjacent to a Processing Plant. Nota Bene, at the end of each turn, any remaining stored commodities, except Leather and Manure, spoil and must be discarded with the relevant inventory dropping to Zero."
		14, 44, 74, 104:
			sTxt = "[b]Leather Store Module[/b][br][br]"
			sTxt += "Allowed = 1[br]Cost = $5[br]Energy Required = 1[br][br]"
			sTxt += "These can store up to 10 units of Leather which can be sold, along with the other commodities, at a Portal. All commodity Storage modules must be adjacent to a Processing Plant.[br][br]NB: at the end of each turn, any remaining stored commodities (except Leather and Manure) spoil and must be discarded with the relevant inventory dropping to Zero."
			sTxtSpeech = "Leather Store Module. Allowed = 1. Cost = $5. Energy Required = 1. "
			sTxtSpeech += "These can store up to 10 units of Leather which can be sold, along with the other commodities, at a Portal. All commodity Storage modules must be adjacent to a Processing Plant. Nota Bene, at the end of each turn, any remaining stored commodities, except Leather and Manure, spoil and must be discarded with the relevant inventory dropping to Zero."
		15, 45, 75, 105:
			sTxt = "[b]Manure Store Module[/b][br][br]"
			sTxt += "Allowed = 1[br]Cost = $5[br]Energy Required = 1[br][br]"
			sTxt += "These can store up to 10 units of Manure, which can be sold, along with the other commodities, at a Portal. All commodity Storage modules must be adjacent to a Processing Plant.[br][br]NB: at the end of each turn, any remaining stored commodities (except Leather and Manure) spoil and must be discarded with the relevant inventory dropping to Zero."
			sTxtSpeech = "Manure Store Module. Allowed = 1. Cost = $5. Energy Required = 1. "
			sTxtSpeech += "These can store up to 10 units of Manure which can be sold, along with the other commodities, at a Portal. All commodity Storage modules must be adjacent to a Processing Plant. Nota Bene, at the end of each turn, any remaining stored commodities, except Leather and Manure, spoil and must be discarded with the relevant inventory dropping to Zero."
		16, 46, 76, 106:
			sTxt = "[b]Milk Store Module[/b][br][br]"
			sTxt += "Allowed = 1[br]Cost = $5[br]Energy Required = 1[br][br]"
			sTxt += "These can store up to 10 units of Milk, which can be sold, along with the other commodities, at a Portal. All commodity Storage modules must be adjacent to a Processing Plant.[br][br]NB: at the end of each turn, any remaining stored commodities (except Leather and Manure) spoil and must be discarded with the relevant inventory dropping to Zero."
			sTxtSpeech = "Milk Store Module. Allowed = 1. Cost = $5. Energy Required = 1. "
			sTxtSpeech += "These can store up to 10 units of Milk which can be sold, along with the other commodities, at a Portal. All commodity Storage modules must be adjacent to a Processing Plant. Nota Bene, at the end of each turn, any remaining stored commodities, except Leather and Manure, spoil and must be discarded with the relevant inventory dropping to Zero."
		17, 47, 77, 107:
			sTxt = "[b]Barn Module[/b][br][br]"
			sTxt += "Allowed = 7[br]Cost = $10[br]Energy Required = 1[br]Output = 5[br][br]"
			sTxt += "These support one herd of Nano-Cows, including all required feeding and milking equipment. They produce 5 commodity units per turn, or 7 if built on a Lush Pasture grid unit.[br][br]NB: Barns must be adjacent to a Processing Plant."
			sTxtSpeech = "Barn Module. Allowed = 7. Cost = $10. Energy Required = 1. Output = 5. "
			sTxtSpeech += "These support one herd of Nano Cows, including all required feeding and milking equipment. They produce 5 commodity units per turn, or 7 if built on a Lush Pasture grid unit. Nota Bene, Barns must be adjacent to a Processing Plant."
		18, 48, 78, 108:
			sTxt = "[b]Megabarn Module[/b][br][br]"
			sTxt += "Allowed = 1[br]Cost = $20[br]Energy Required = 1[br]Output = 10[br][br]"
			sTxt += "These support two herds of Nano-Cows, including all required feeding and milking equipment. They produce 10 commodity units per turn, or 12 if built on a Lush Pasture grid unit.[br][br]NB: Megabarns must be adjacent to a Processing Plant."
			sTxtSpeech = "Megabarn Module. Allowed = 1. Cost = $20. Energy Required = 1. Output = 10. "
			sTxtSpeech += "These support two herds of Nano Cows, including all required feeding and milking equipment. They produce 10 commodity units per turn, or 12 if built on a Lush Pasture grid unit. Nota Bene, Megabarns must be adjacent to a Processing Plant."
		19, 49, 79, 109:
			sTxt = "[b]Processing Plant Module[/b][br][br]"
			sTxt += "Allowed = 2[br]Cost = $20[br]Energy Required = 2[br][br]"
			sTxt += "These turn the output from the herd into Beef, Butter, Cheese, Cream, Ice Cream, Leather, Manure and/or Milk. There is no limit on how many units of each commodity a Processing Plant can make, except that there must be room in the Storage modules for everything.[br][br]NB: Anything that will not fit in a Storage module is lost and a Processing Plant requires 2 units of energy per turn, not the usual 1."
			sTxtSpeech = "Processing Plant Module. Allowed = 2. Cost = $20. Energy Required = 2. "
			sTxtSpeech += "These turn the output from the herd into Beef, Butter, Cheese, Cream, Ice Cream, Leather, Manure and, or, Milk. There is no limit on how many units of each commodity a Processing Plant can make, except that there must be room in the Storage modules for everything. Nota Bene, Anything that will not fit in a Storage module is lost and a Processing Plant requires 2 units of energy per turn, not the usual 1."
		20, 50, 80, 110:
			sTxt = "[b]Habitation Module[/b][br][br]"
			sTxt += "Allowed = 1[br]Cost = $5[br]Energy Required = 1[br][br]"
			sTxt += "These are living spaces for the workers of the colony, and are required for the colony to exceed 12 modules. In other words, the 13th module must be a Habitation module. Should this module be deprived of energy, then no more modules may be placed until it is functional again."
			sTxtSpeech = "Habitation Module. Allowed = 1. Cost = $5. Energy Required = 1. "
			sTxtSpeech += "These are living spaces for the workers of the colony, and are required for the colony to exceed 12 modules. In other words, the 13th module must be a Habitation module. Should this module be deprived of energy, then no more modules may be placed until it is functional again."
		21, 51, 81, 111:
			sTxt = "[b]Cheese Lab Module[/b][br][br]"
			sTxt += "Allowed = 1[br]Cost = $10[br]Cash Produced = $4[br]Energy Required = 1[br][br]"
			sTxt += "These generate $4 each turn through research into new flavours of Cheeses, and will generate $ whether there is a functional Portal or not."
			sTxtSpeech = "Cheese Lab Module. Allowed = 1. Cost = $10. Cash Produced = $4. Energy Required = 1. "
			sTxtSpeech += "These generate $4 each turn through research into new flavours of Cheeses, and will generate money whether there is a functional Portal or not."
		22, 52, 82, 112:
			sTxt = "[b]Sausage Lab Module[/b][br][br]"
			sTxt += "Allowed = 1[br]Cost = $10[br]Cash Produced = $4[br]Energy Required = 1[br][br]"
			sTxt += "These generate $4 each turn through research into new flavours of Sausages, and will generate $ whether there is a functional Portal or not."
			sTxtSpeech = "Sausage Lab Module. Allowed = 1. Cost = $10. Cash Produced = $4. Energy Required = 1. "
			sTxtSpeech += "These generate $4 each turn through research into new flavours of Sausages, and will generate money whether there is a functional Portal or not."
		23, 53, 83, 113:
			sTxt = "[b]Pasture Dome Module[/b][br][br]"
			sTxt += "Allowed = 3[br]Cost = $5[br]Energy Required = 1[br][br]"
			sTxt += "These are enclosed grazing areas, which must be adjacent to a Barn or Megabarn. Bad things can happen if there is not at least one Pasture Dome for each 3 Barn's worth of Nano-Cows (count one Megabarn as two Barns)."
			sTxtSpeech = "Pasture Dome Module. Allowed = 3. Cost = $5. Energy Required = 1. "
			sTxtSpeech += "These are enclosed grazing areas, which must be adjacent to a Barn or Megabarn. Bad things can happen if there is not at least one Pasture Dome for each 3 Barn's worth of Nano-Cows. Count one Megabarn as two Barns."
		24, 54, 84, 114:
			sTxt = "[b]Law Office Module[/b][br][br]"
			sTxt += "Allowed = 1[br]Cost = $15[br]Energy Required = 1[br][br]"
			sTxt += "These are full of greedy corporate lawyers who are eager to sue the udders off the competition. Each turn, a colony can choose to file a suit against another colony for infringement of grazing rights, a strawberry tort, or whatever else they can think of. All lawsuits are decided by the roll of a dice. If it comes up 1-4, multiply by 10, and that's what the colony receives in reparations. If it's a 5, the case was dismissed, and a 6 means the court found for the other colony, who must be paid $25 in damages."
			sTxtSpeech = "Law Office Module. Allowed = 1. Cost = $15. Energy Required = 1. "
			sTxtSpeech += "These are full of greedy corporate lawyers who are eager to sue the udders off the competition. Each turn, a colony can choose to file a suit against another colony for infringement of grazing rights, a strawberry tort, or whatever else they can think of. All lawsuits are decided by the roll of a dice. If it comes up 1 to 4, multiply by 10, and that's what the colony receives in reparations. If it's a 5, the case was dismissed, and a 6 means the court found for the other colony, who must be paid $25 in damages."

	if xx > -1000:
		var parent = hover.get_parent()
		var current_index = hover.get_index()

		if current_index == 0 and xx < 30:
			parent.move_child(hover, 1)
		elif current_index == 1 and xx >= 30:
			parent.move_child(hover, 0)

	hoverTxt.text = sTxt
	hover.visible = true

	if UniversalSettings.settings_data.voice_volume > 0.01:
		TTS.call_deferred("speak", sTxtSpeech)

func _on_music_finished() -> void:
	var curMusic = Globals.music[randi() % 20]
	var audio_stream = load("res://Assets/Sounds/Music/" + curMusic)
	$Music.stream = audio_stream
	$Music.play()
