extends Node

var tAvailableMods = []		# Available Modules - from 1 - COUNT NB: Need to ensure 0 is a dummy value
# tAvailableMods.append({"I": 0, "F": "Dummy.tscn", "F2": "Dummy_128.jpg", "N": "Dummy", "CO": 0, "CA": 0, "EP": 0, "ER": 0, "OU": 0, "ST": 0, "ON": "N", "SI": "N"})
var tCamPos = [
	{"xx": 0, "yy": 0, "zz": 0},
	{"xx": 0, "yy": 0, "zz": 0},
	{"xx": 0, "yy": 0, "zz": 0},
	{"xx": 0, "yy": 0, "zz": 0},
	{"xx": 0, "yy": 0, "zz": 0},
	]			# Camera position for viewing StartUp Module of each player {"xx": 0, "yy": 0, "zz": 0}

var tREOther = [
	{"giftboxes": 10, "keepunsold": false, "losegeo": false, "newdisease": false, "labs": 4, "cureall": false, "losebarn": false, "reroll": false, "nocatalog": false},
	{"giftboxes": 10, "keepunsold": false, "losegeo": false, "newdisease": false, "labs": 4, "cureall": false, "losebarn": false, "reroll": false, "nocatalog": false},
	{"giftboxes": 10, "keepunsold": false, "losegeo": false, "newdisease": false, "labs": 4, "cureall": false, "losebarn": false, "reroll": false, "nocatalog": false},
	{"giftboxes": 10, "keepunsold": false, "losegeo": false, "newdisease": false, "labs": 4, "cureall": false, "losebarn": false, "reroll": false, "nocatalog": false},
	{"giftboxes": 10, "keepunsold": false, "losegeo": false, "newdisease": false, "labs": 4, "cureall": false, "losebarn": false, "reroll": false, "nocatalog": false},
	]			# {"giftboxes": false, "keepunsold": true, "losegeo": true, "newdisease": true, "labs": 4, "cureall": true, "losebarn": true, "reroll": true, "nocatalog": true }

var dragObject = null
var selObject = null

var bDrag = false
var bModuleMoved = false

var sMyName = ""

var iBarn = 0
var iButtons = 0
var iCommodityCount = 1
var iConX = 0
var iConY = 0
var iCount = 0
var iCrystal = 0
var iCurModDND = 0
var iCurPage = 1
var iDice1 = 0
var iDice2 = 0
var iEnergy = 0
var iEnergyType = 0
var iGeothermal = 0
var iGiftSell = 0
var iMegaBarn = 0
var iModules = 0
var iMyID = 0
var iMyPN = 0
var iPlacedX = 0
var iPlacedY = 0
var iPrevArea = 0
var iPrice = 0
var iProduction = 0
var iSales = 0
var iStoreDiff = 0
var iSue = 0
var iWait = -1
var optVoice = 0
var iAvailArea = 0
var bStarted = false

var mDirt = preload("res://Materials/dirt.tres")

var music = [
	"celestial_cycle.ogg",
	"city_lights.ogg",
	"crytalise.ogg",
	"dark_planet.ogg",
	"disolve.ogg",
	"dna.ogg",
	"endspace.ogg",
	"inbetween_worlds.ogg",
	"journey_forward.ogg",
	"outer_rim.ogg",
	"rays_of_kalia.ogg",
	"science.ogg",
	"spheres.ogg",
	"streamed.ogg",
	"street_stories.ogg",
	"sunrise_over_new_tokyo.ogg",
	"survivor.ogg",
	"tides_of_jupiter.ogg",
	"time.ogg",
	"wormhole.ogg"
]

var sfx_click = preload("res://Assets/Sounds/Effects/Button_Press.mp3")
var sfx_dice = preload("res://Assets/Sounds/Effects/Dice.mp3")
var sfx_msg = preload("res://Assets/Sounds/Effects/Message.mp3")
var sfx_error = preload("res://Assets/Sounds/Effects/GUI_Sound_Effects_by_Lokif/GUI_Sound_Effects_by_Lokif/negative.wav")
var sfx_ok = preload("res://Assets/Sounds/Effects/GUI_Sound_Effects_by_Lokif/GUI_Sound_Effects_by_Lokif/positive.wav")

var curMusicPos = 0.0
