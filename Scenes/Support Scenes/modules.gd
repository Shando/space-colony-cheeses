extends Node3D

@onready var sickIcon = preload("res://Scenes/Support Scenes/cross.tscn")
@onready var energyIcon = preload("res://Scenes/Support Scenes/lightning.tscn")

var cooldown = 10

func _on_StaticBody_input_event(_camera, event, _pos, _normal, _shape_idx):
	var global = get_tree().get_root().get_node("Spatial")

	if event is InputEventMouseButton and event.pressed:
		var myID = self.get_name()
		var iT = -1
		var xx = -1
		var yy = -1

		for x in range(1, 17):
			for y in range(1, 13):
				if typeof(global.tModels[x][y]) == TYPE_STRING_NAME:
					if global.tModels[x][y] == myID:
						iT = global.tBuildings[x][y]
						xx = x
						yy = y
						break

		if iT > (global.iCurPlay * 30) - 30 and iT < global.iCurPlay * 30:
			match Globals.iWait:
				Messages.Msg.WAIT_MOVE_MODULES:
					Globals.bDrag = true
					Globals.dragObject = self
					Globals.selObject = null
					global.tSickIcons[position.x][position.y] = -1
					global.tOfflineIcons[position.x][position.y] = -1
				Messages.Msg.WAIT_NEW_DISEASE:
					if iT == (global.iCurPlay * 30) - 12 or iT == (global.iCurPlay * 30) - 13:
						if global.tModules[xx][yy].sick == "N":
							var sI = GDSync.multiplayer_instantiate(sickIcon, self, true, [], false)
							GDSync.set_gdsync_owner(self, GDSync.get_client_id())
							sI.position = Vector3(position.x, 4, position.y)
							sI.scale = Vector3(0.1, 0.1, 0.1)
							global.tSickIcons[xx][yy] = int(sI.get_name())
							global.updateModules(xx, yy, 0, "Y")
							GDSync.call_func(global.updateModules, [xx, yy, 0, "Y"])
							global.updateNumDisease(1)
							GDSync.call_func(global.updateNumDisease, [1])
						else:
							var sT = "Spatial/Buildings/" + str(global.tModels[xx][yy]) + "/" + str(global.tSickIcons[xx][yy])
							var instance = get_tree().get_root().get_node(sT)
							Functions.freeNode(sT)
							GDSync.call_func(Functions.freeNode, [sT])
							instance.queue_free()
							global.updateModules(xx, yy, 0, "N")
							GDSync.call_func(global.updateModules, [xx, yy, 0, "N"])
							global.updateNumDisease(-1)
							GDSync.call_func(global.updateNumDisease, [-1])
							global.tSickIcons[xx][yy] = -1
				Messages.Msg.WAIT_ENERGY:
					if iT > 30 * global.iCurPlay - 3 and iT < 30 * global.iCurPlay - 11:
						if global.tModules[xx][yy].online == "N":
							var eI = GDSync.multiplayer_instantiate(energyIcon, self, true, [], false)
							GDSync.set_gdsync_owner(self, GDSync.get_client_id())
							eI.position = Vector3(position.x, 8, position.y)
							eI.scale = Vector3(0.01, 0.01, 0.01)
							global.tOfflineIcons[xx][yy] = int(energyIcon.get_name())
							global.updateModules(xx, yy, 1, "Y")
							GDSync.call_func(global.updateModules, [xx, yy, 1, "Y"])
						else:
							var sT = "Spatial/Buildings/" + str(global.tModels[xx][yy]) + "/" + str(global.tOfflineIcons[xx][yy])
							var instance = get_tree().get_root().get_node(sT)
							Functions.freeNode(sT)
							GDSync.call_func(Functions.freeNode, [sT])
							instance.queue_free()
							global.updateModules(xx, yy, 1, "N")
							GDSync.call_func(global.updateModules, [xx, yy, 1, "N"])
							global.tOfflineIcons[xx][yy] = -1
				Messages.Msg.REMOVE_BARN:
					if iT == (global.iCurPlay * 30) - 12 or iT == (global.iCurPlay * 30) - 13:
						var sT = ""
					
						if global.tSickIcons[xx][yy] > -1:
							sT = "Spatial/Buildings/" + str(global.tModels[xx][yy]) + "/" + str(global.tSickIcons[xx][yy])
							var instance = get_tree().get_root().get_node(sT)
							Functions.freeNode(sT)
							GDSync.call_func(Functions.freeNode, [sT])
							instance.queue_free()
							global.updateModules(xx, yy, 0, "N")
							GDSync.call_func(global.updateModules, [xx, yy, 0, "N"])
							global.updateNumDisease(-1)
							GDSync.call_func(global.updateNumDisease, [-1])
							global.tSickIcons[xx][yy] = -1

						if global.tOfflineIcons[xx][yy] > -1:
							sT = "Spatial/Buildings/" + str(global.tModels[xx][yy]) + "/" + str(global.tOfflineIcons[xx][yy])
							var instance = get_tree().get_root().get_node(sT)
							Functions.freeNode(sT)
							GDSync.call_func(Functions.freeNode, [sT])
							instance.queue_free()
							global.updateModules(xx, yy, 1, "N")
							GDSync.call_func(global.updateModules, [xx, yy, 1, "N"])
							global.tOfflineIcons[xx][yy] = -1

						for x in global.tMods:
							if x.id == iT:
								x.max += 1
								break

						global.updateNumModules(-1)
						GDSync.call_func(global.updateNumModules, [-1])
						global.updateModels(xx, yy, -1)
						GDSync.call_func(global.updateModels, [xx, yy, -1])
						global.updateBuildings(xx, yy, -1)
						GDSync.call_func(global.updateBuildings, [xx, yy, -1])
						global.updateModules(xx, yy, 99, "N")
						GDSync.call_func(global.updateModules, [xx, yy, 99, "N"])
						sT = get_path()
						Functions.freeNode(sT)
						GDSync.call_func(Functions.freeNode, [sT])
						self.queue_free()

func _on_static_body_mouse_entered() -> void:
	if TTS.is_speaking():
		TTS.stop()

	var myID = self.get_name()
	var global = get_tree().get_root().get_node("Spatial")
	var iT = -1
	var xx = 0

	for x in range(1, 17):
		for y in range(1, 13):
			if typeof(global.tModels[x][y]) == TYPE_STRING_NAME:
				if global.tModels[x][y] == myID:
					iT = global.tBuildings[x][y]
					xx = global.tBoardLoc[x][y][0]
					break

	if iT > -1:
		global.hoverText(iT, xx)

func _on_static_body_mouse_exited() -> void:
	if TTS.is_speaking():
		TTS.stop()

	var global = get_tree().get_root().get_node("Spatial")
	global.hideHover()
