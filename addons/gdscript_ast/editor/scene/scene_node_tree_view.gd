# addons/gdscript_ast/editor/scene/scene_node_tree_view.gd
# 节点树视角 — 场景列表 + Tree + 节点详情 + 跳转脚本
# Chunk B

class_name SceneNodeTreeView
extends VBoxContainer

var _bridge: GDSAnalysisBridge = null
var _l10n: GDSL10n = null
var _navigate: Callable = Callable()
var _scene_list: ItemList = null
var _tree: Tree = null
var _detail: VBoxContainer = null
var _connection_tree: Tree = null
var _connection_label: Label = null
var _current_scene: String = ""

func setup(p_bridge, p_l10n, p_navigate: Callable) -> void:
	_bridge = p_bridge
	_l10n = p_l10n
	_navigate = p_navigate
	_build_ui()

func _build_ui() -> void:
	set_anchors_and_offsets_preset(PRESET_FULL_RECT)
	size_flags_horizontal = SIZE_EXPAND_FILL
	size_flags_vertical = SIZE_EXPAND_FILL

	var hsplit = HSplitContainer.new()
	hsplit.size_flags_horizontal = SIZE_EXPAND_FILL
	hsplit.size_flags_vertical = SIZE_EXPAND_FILL
	add_child(hsplit)

	# 左侧: 场景列表（底色 1）
	var left_box = VBoxContainer.new()
	var left_label = Label.new()
	left_label.text = _l10n.t("scope.project")
	left_box.add_child(left_label)
	_scene_list = ItemList.new()
	_scene_list.size_flags_horizontal = SIZE_EXPAND_FILL
	_scene_list.size_flags_vertical = SIZE_EXPAND_FILL
	_scene_list.item_selected.connect(_on_scene_selected)
	left_box.add_child(_scene_list)
	var left_panel = _make_bordered_panel(left_box, Color(0.13, 0.13, 0.16))
	left_panel.custom_minimum_size = Vector2(200, 0)
	hsplit.add_child(left_panel)

	# 中间: VSplitContainer（节点树 + 连接表格）
	var center_split = VSplitContainer.new()
	center_split.size_flags_horizontal = SIZE_EXPAND_FILL
	center_split.size_flags_vertical = SIZE_EXPAND_FILL

	_tree = Tree.new()
	_tree.size_flags_horizontal = SIZE_EXPAND_FILL
	_tree.size_flags_vertical = SIZE_EXPAND_FILL
	_tree.columns = 1
	_tree.item_selected.connect(_on_tree_node_selected)
	center_split.add_child(_tree)

	var connection_box = VBoxContainer.new()
	connection_box.size_flags_horizontal = SIZE_EXPAND_FILL
	connection_box.size_flags_vertical = SIZE_EXPAND_FILL

	_connection_label = Label.new()
	_connection_label.text = _l10n.t("detail.scene_signal_connections")
	connection_box.add_child(_connection_label)

	_connection_tree = Tree.new()
	_connection_tree.size_flags_horizontal = SIZE_EXPAND_FILL
	_connection_tree.size_flags_vertical = SIZE_EXPAND_FILL
	_connection_tree.columns = 4
	_connection_tree.column_titles_visible = true
	_connection_tree.set_column_title(0, _l10n.t("connection.signal"))
	_connection_tree.set_column_title(1, _l10n.t("connection.from"))
	_connection_tree.set_column_title(2, _l10n.t("connection.to"))
	_connection_tree.set_column_title(3, _l10n.t("connection.method"))
	_connection_tree.hide_root = true
	_connection_tree.item_activated.connect(_on_connection_activated)
	connection_box.add_child(_connection_tree)
	center_split.add_child(connection_box)

	var center_panel = _make_bordered_panel(center_split, Color(0.10, 0.10, 0.12))
	hsplit.add_child(center_panel)

	# 右侧: 节点详情（底色 3，略蓝）
	_detail = VBoxContainer.new()
	var right_panel = _make_bordered_panel(_detail, Color(0.13, 0.14, 0.17))
	right_panel.custom_minimum_size = Vector2(250, 0)
	hsplit.add_child(right_panel)


# 带边框+底色的 PanelContainer（区域视觉分块）
func _make_bordered_panel(p_content: Control, p_bg: Color) -> PanelContainer:
	var panel = PanelContainer.new()
	var style = StyleBoxFlat.new()
	style.bg_color = p_bg
	style.border_width_left = 1
	style.border_width_top = 1
	style.border_width_right = 1
	style.border_width_bottom = 1
	style.border_color = Color(0.30, 0.30, 0.35)
	style.corner_radius_top_left = 4
	style.corner_radius_top_right = 4
	style.corner_radius_bottom_left = 4
	style.corner_radius_bottom_right = 4
	style.content_margin_left = 6
	style.content_margin_right = 6
	style.content_margin_top = 4
	style.content_margin_bottom = 4
	panel.add_theme_stylebox_override("panel", style)
	panel.size_flags_horizontal = SIZE_EXPAND_FILL
	panel.size_flags_vertical = SIZE_EXPAND_FILL
	panel.add_child(p_content)
	return panel

func rebuild() -> void:
	_scene_list.clear()
	_tree.clear()
	_connection_tree.clear()
	_clear_detail()

	var proj = _bridge.get_project_result()
	if proj == null:
		return

	var scene_paths = proj.scenes.keys()
	scene_paths.sort()
	for spath in scene_paths:
		var idx = _scene_list.add_item(spath)
		var scene = proj.scenes[spath]
		# 解析失败标红
		if scene and scene.errors.size() > 0:
			_scene_list.set_item_custom_fg_color(idx, Color.RED)
			_scene_list.set_item_tooltip(idx, "\n".join(scene.errors))

func _on_scene_selected(_idx: int) -> void:
	var selected = _scene_list.get_selected_items()
	if selected.is_empty():
		return
	var idx = selected[0]
	_current_scene = _scene_list.get_item_text(idx)
	_build_tree()
	_build_connections_table()

func _build_tree() -> void:
	_tree.clear()
	_clear_detail()
	var proj = _bridge.get_project_result()
	if proj == null or not proj.scenes.has(_current_scene):
		return
	var scene = proj.scenes[_current_scene]
	var root = _tree.create_item()
	for n in scene.root_nodes:
		_add_tree_node(root, n, "")

# 构建中间面板 Connections 表格（按 Signal 名字母序）
func _build_connections_table() -> void:
	_connection_tree.clear()
	var proj = _bridge.get_project_result()
	if proj == null or not proj.scenes.has(_current_scene):
		_connection_label.text = _l10n.t("msg.no_scene_connections")
		return
	var scene = proj.scenes[_current_scene]
	var conns: Array = scene.signal_connections.duplicate()
	if conns.is_empty():
		_connection_label.text = _l10n.t("msg.no_scene_connections")
		return

	_connection_label.text = _l10n.t("detail.scene_signal_connections")

	# 按 Signal 名字母序排序（用户确认）
	conns.sort_custom(func(a, b): return a.signal_name < b.signal_name)

	var root = _connection_tree.create_item()
	for conn in conns:
		var item = _connection_tree.create_item(root)
		item.set_text(0, conn.signal_name)
		item.set_text(1, conn.from_node)
		item.set_text(2, conn.to_node)
		item.set_text(3, conn.method)
		item.set_metadata(0, {"from_node": conn.from_node})

# 递归构建 Tree + 记录完整 NodePath
func _add_tree_node(parent: TreeItem, node, parent_path: String) -> void:
	var item = _tree.create_item(parent)
	var label = node.name + " (" + node.type + ")"
	if node.script_resource != "":
		label = "📜 " + label
	if node.is_instance():
		label = "📦 " + label
	item.set_text(0, label)
	var full_path = _node_full_path(node, parent_path)
	item.set_metadata(0, {"path": full_path, "node": node})
	for child in node.children:
		_add_tree_node(item, child, full_path)

# 递归构建完整 NodePath（用于树形展示 / 联动定位）
func _node_full_path(node, parent_path: String) -> String:
	if parent_path == "":
		return node.name
	return parent_path + "/" + node.name

# 构建 tscn 格式的相对路径（用于信号连接查询）
func _node_connection_path(node) -> String:
	if node.parent_path == "" or node.parent_path == ".":
		return node.name
	return node.parent_path + "/" + node.name

func _on_tree_node_selected() -> void:
	var selected = _tree.get_selected()
	if selected == null:
		return
	var meta = selected.get_metadata(0)
	if meta == null or not meta.has("node"):
		return
	_show_detail(meta.node, meta.get("path", ""))

func _show_detail(node, node_path: String = "") -> void:
	_clear_detail()

	_add_detail_line(_l10n.t("detail.name") + ": " + node.name)
	_add_detail_line(_l10n.t("detail.type") + ": " + node.type)
	_add_detail_line(_l10n.t("detail.parent") + ": " + node.parent_path)

	# groups
	var groups_str = ""
	if node.groups and node.groups.size() > 0:
		groups_str = ", ".join(node.groups)
	else:
		groups_str = _l10n.t("msg.none")
	_add_detail_line(_l10n.t("detail.groups") + ": " + groups_str)

	# 分隔
	_add_detail_line("---")

	# script_resource — 做成 Button 跳转
	var script_label = Label.new()
	script_label.text = _l10n.t("detail.script") + ":"
	_detail.add_child(script_label)

	if node.script_resource != "" and ResourceLoader.exists(node.script_resource):
		var script_btn = Button.new()
		script_btn.text = node.script_resource
		script_btn.flat = true
		script_btn.tooltip_text = _l10n.t("detail.jump_script")
		script_btn.pressed.connect(_on_jump_script.bind(node.script_resource))
		_detail.add_child(script_btn)
	elif node.script_resource != "":
		_add_detail_line(node.script_resource + " " + _l10n.t("msg.not_found"))
	else:
		_add_detail_line(_l10n.t("msg.none"))

	# 分隔
	_add_detail_line("---")

	# Chunk A3: instance 子场景实例标注
	if node.is_instance():
		var instance_label = Label.new()
		instance_label.text = _l10n.t("detail.instance")
		_detail.add_child(instance_label)

		if node.instance_resource != "" and ResourceLoader.exists(node.instance_resource):
			var instance_btn = Button.new()
			instance_btn.text = node.instance_resource
			instance_btn.flat = true
			instance_btn.tooltip_text = _l10n.t("detail.jump_scene")
			instance_btn.pressed.connect(_on_jump_scene.bind(node.instance_resource))
			_detail.add_child(instance_btn)
		elif node.instance_resource != "":
			_add_detail_line(node.instance_resource + " " + _l10n.t("msg.not_found"))
		else:
			_add_detail_line(_l10n.t("msg.unknown"))

		_add_detail_line("---")

	# 场景信号连接（tscn [connection]）
	var scene_sig_label = Label.new()
	scene_sig_label.text = _l10n.t("detail.scene_signal_connections") + ":"
	_detail.add_child(scene_sig_label)

	var proj = _bridge.get_project_result()
	if proj and proj.scenes.has(_current_scene):
		var scene = proj.scenes[_current_scene]
		var conn_path = _node_connection_path(node)
		var conns = scene.get_connections_for_node(conn_path)
		if conns.size() > 0:
			for c in conns:
				var conn_text = "%s: %s → %s.%s" % [c.signal_name, c.from_node, c.to_node, c.method]
				_add_detail_line("  " + conn_text)
		else:
			_add_detail_line("  " + _l10n.t("msg.no_scene_connections"))
	else:
		_add_detail_line("  " + _l10n.t("msg.no_scene_connections"))

	# 分隔
	_add_detail_line("---")

	# 代码信号连接（脚本中显式 connect()）
	var code_sig_label = Label.new()
	code_sig_label.text = _l10n.t("detail.code_signal_connections") + ":"
	_detail.add_child(code_sig_label)

	if node.script_resource == "":
		_add_detail_line("  " + _l10n.t("msg.no_script_for_code_connections"))
	else:
		var result = _bridge.get_cached(node.script_resource)
		if result == null:
			_add_detail_line("  " + _l10n.t("msg.unknown"))
		else:
			var found = false
			for edge in result.call_graph.edges:
				if edge.call_type == GDScriptCallEdge.CallType.SIGNAL_CONNECT:
					found = true
					_add_code_signal_edge_line(edge, node.script_resource)
			if not found:
				_add_detail_line("  " + _l10n.t("msg.no_code_connections"))

	# 分隔
	_add_detail_line("---")

	# 入向代码信号连接（其他脚本 connect 到当前节点脚本）
	var incoming_label = Label.new()
	incoming_label.text = _l10n.t("detail.incoming_code_signal_connections") + ":"
	_detail.add_child(incoming_label)

	if node.script_resource == "":
		_add_detail_line("  " + _l10n.t("msg.no_script_for_code_connections"))
	else:
		var incoming_found = false
		var project_result = _bridge.get_project_result()
		if project_result != null:
			var incoming_edges = project_result.get_incoming_cross_edges(node.script_resource)
			for edge in incoming_edges:
				if edge.kind == GDSCrossFileEdge.Kind.SIGNAL_CONNECT and edge.callback != "":
					incoming_found = true
					var src_file = edge.source_file.get_file()
					var sig = edge.target_symbol
					var cb = edge.callback
					var incoming_hbox = HBoxContainer.new()
					var incoming_prefix = Label.new()
					incoming_prefix.text = "  %s: %s → " % [src_file, sig]
					incoming_hbox.add_child(incoming_prefix)
					var incoming_cb_btn = Button.new()
					incoming_cb_btn.text = cb
					incoming_cb_btn.flat = true
					incoming_cb_btn.tooltip_text = _l10n.t("detail.jump_script")
					incoming_cb_btn.pressed.connect(_on_jump_script_line.bind(edge.source_file, edge.line))
					incoming_hbox.add_child(incoming_cb_btn)
					_detail.add_child(incoming_hbox)
		if not incoming_found:
			_add_detail_line("  " + _l10n.t("msg.no_incoming_code_connections"))

func _add_detail_line(p_text: String) -> void:
	var label = Label.new()
	label.text = p_text
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	label.size_flags_horizontal = SIZE_EXPAND_FILL
	_detail.add_child(label)

func _add_code_signal_edge_line(edge: GDScriptCallEdge, script_path: String) -> void:
	var callback = _format_signal_callback(edge.arguments)
	var hbox = HBoxContainer.new()

	if edge.callee == callback:
		# self.signal.connect(cb) → 显示 self.signal → cb
		var label = Label.new()
		label.text = "self.%s → " % edge.target_object
		hbox.add_child(label)
	else:
		# obj.signal.connect(cb) → 显示 obj.signal → cb
		var obj_btn = _make_code_signal_source_button(edge.target_object)
		if obj_btn != null:
			hbox.add_child(obj_btn)
		else:
			var obj_label = Label.new()
			obj_label.text = edge.target_object
			hbox.add_child(obj_label)
		var dot_label = Label.new()
		dot_label.text = ".%s → " % edge.callee
		hbox.add_child(dot_label)

	var cb_btn = Button.new()
	cb_btn.text = callback
	cb_btn.flat = true
	cb_btn.tooltip_text = _l10n.t("detail.jump_script")
	cb_btn.pressed.connect(_on_jump_script_line.bind(script_path, edge.site_line))
	hbox.add_child(cb_btn)

	_detail.add_child(hbox)

func _format_signal_callback(arguments: Array) -> String:
	if arguments == null or arguments.is_empty():
		return "?"
	return GDSExprFormatter.format(arguments[0])

func _make_code_signal_source_button(p_name: String) -> Button:
	var proj = _bridge.get_project_result()
	if proj == null or not proj.scenes.has(_current_scene):
		return null
	var scene = proj.scenes[_current_scene]
	var lookup_name = p_name.trim_prefix("$")
	for path in scene.nodes_flat:
		var n = scene.nodes_flat[path]
		if n.name == lookup_name:
			var btn = Button.new()
			btn.text = p_name
			btn.flat = true
			btn.tooltip_text = _l10n.t("detail.jump_scene")
			btn.pressed.connect(_on_focus_scene_node.bind(path))
			return btn
	return null

func _on_focus_scene_node(p_path: String) -> void:
	if GDSGraphMainScreen.is_locked:
		return
	_expand_to_node(p_path)

func _on_jump_script_line(p_path: String, p_line: int) -> void:
	if GDSGraphMainScreen.is_locked:
		return
	if p_path == "" or not ResourceLoader.exists(p_path):
		return
	var scr = load(p_path)
	if scr:
		EditorInterface.edit_script(scr, p_line)
		EditorInterface.set_main_screen_editor("Script")

func _clear_detail() -> void:
	for c in _detail.get_children():
		c.queue_free()

func _on_jump_script(path: String) -> void:
	_on_jump_script_line(path, -1)

func _on_jump_scene(path: String) -> void:
	if GDSGraphMainScreen.is_locked:
		return
	if path == "" or not ResourceLoader.exists(path):
		return
	if path.ends_with(".tscn") or path.ends_with(".scn"):
		EditorInterface.open_scene_from_path(path)
	else:
		# 兜底：其他资源用资源编辑器打开
		var res = load(path)
		if res:
			EditorInterface.edit_resource(res)

# 双击连接行 → 跳转 From 节点（树中展开 + 选中）
func _on_connection_activated() -> void:
	var selected = _connection_tree.get_selected()
	if selected == null:
		return
	var meta = selected.get_metadata(0)
	if meta == null or not meta.has("from_node"):
		return
	var from_path: String = meta["from_node"]
	if from_path == ".":
		# tscn 中 "." 表示根节点，取根节点名
		var proj = _bridge.get_project_result()
		if proj and proj.scenes.has(_current_scene):
			var scene = proj.scenes[_current_scene]
			if not scene.root_nodes.is_empty():
				from_path = scene.root_nodes[0].name
	_expand_to_node(from_path)

# 供联动调用：选场景→展开树到 node_path→选中
func focus_node(scene_path: String, node_path: String) -> void:
	# 选中对应场景
	var item_count = _scene_list.get_item_count()
	for i in range(item_count):
		if _scene_list.get_item_text(i) == scene_path:
			_scene_list.select(i)
			_current_scene = scene_path
			_build_tree()
			_build_connections_table()
			# 展开树到目标节点
			_expand_to_node(node_path)
			return

func _expand_to_node(node_path: String) -> void:
	var root = _tree.get_root()
	if root == null:
		return
	var parts = _normalize_path_to_parts(node_path)
	if parts.is_empty():
		return
	if parts.size() > 1:
		# 完整路径: 逐层展开；失败时回退到末段节点名全树搜索
		if not _walk_and_expand(root, parts, 0):
			_search_and_expand(root, parts[parts.size() - 1])
	else:
		# 单节点名: 递归搜索整棵树
		_search_and_expand(root, node_path)

# 将 tscn / nodes_flat 路径统一转换为以场景根节点名为首的路径段数组，
# 兼容 "Root/Child"（树形完整路径）与 "Child/GrandChild"（根相对路径）两种风格
func _normalize_path_to_parts(node_path: String) -> PackedStringArray:
	var parts = node_path.split("/")
	if parts.is_empty():
		return parts
	var proj = _bridge.get_project_result()
	if proj != null and proj.scenes.has(_current_scene):
		var scene = proj.scenes[_current_scene]
		if not scene.root_nodes.is_empty():
			var root_name = scene.root_nodes[0].name
			if parts[0] != root_name:
				parts.insert(0, root_name)
	return parts

func _walk_and_expand(item: TreeItem, parts: Array, depth: int) -> bool:
	if depth >= parts.size() or item == null:
		return false
	var target = parts[depth]
	var child = item.get_first_child()
	while child:
		var meta = child.get_metadata(0)
		if meta and meta.has("node") and meta.node.name == target:
			child.collapsed = false
			if depth == parts.size() - 1:
				child.select(0)
				_tree.scroll_to_item(child)
				return true
			if _walk_and_expand(child, parts, depth + 1):
				return true
			return false
		child = child.get_next()
	return false

# 递归搜索：按节点名在整棵树中查找（用于反查联动，短名匹配）
func _search_and_expand(item: TreeItem, target_name: String) -> bool:
	var meta = item.get_metadata(0)
	if meta and meta.has("node") and meta.node.name == target_name:
		item.select(0)
		_tree.scroll_to_item(item)
		# 展开所有祖先节点
		var p = item.get_parent()
		while p:
			p.collapsed = false
			p = p.get_parent()
		return true
	var child = item.get_first_child()
	while child:
		if _search_and_expand(child, target_name):
			return true
		child = child.get_next()
	return false
