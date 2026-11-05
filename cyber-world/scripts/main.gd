extends Node3D

const SAVE_PATH := "user://hacker_protocol_lab.cfg"
const THEME_COLORS: Array[Color] = [
    Color(0.04, 0.72, 0.92),
    Color(0.48, 0.30, 0.95),
    Color(0.12, 0.88, 0.52)
]

var theme_index := 0
var upgrade_level := 1
var objective_label: Label
var status_label: Label

func _ready() -> void:
    _build_lab()
    _build_hud()
    _load_progress()

func _build_lab() -> void:
    # Main room shell and structural pillars.
    _add_box(Vector3(-4, 1.0, -4), Vector3(1.2, 2.0, 1.2), Color(0.04, 0.12, 0.2))
    _add_box(Vector3(4, 1.0, -4), Vector3(1.2, 2.0, 1.2), Color(0.04, 0.12, 0.2))
    _add_box(Vector3(-4, 1.0, 4), Vector3(1.2, 2.0, 1.2), Color(0.04, 0.12, 0.2))
    _add_box(Vector3(4, 1.0, 4), Vector3(1.2, 2.0, 1.2), Color(0.04, 0.12, 0.2))
    _add_box(Vector3(0, 2.5, -11.5), Vector3(24, 5, 0.4), Color(0.025, 0.04, 0.09))

    # Main workstation: desk, dual monitors and keyboard.
    _add_box(Vector3(0, 0.78, -2.7), Vector3(4.8, 0.18, 1.45), Color(0.025, 0.055, 0.085))
    _add_box(Vector3(-1.65, 0.4, -2.7), Vector3(0.16, 0.78, 1.2), Color(0.035, 0.08, 0.12))
    _add_box(Vector3(1.65, 0.4, -2.7), Vector3(0.16, 0.78, 1.2), Color(0.035, 0.08, 0.12))
    _add_box(Vector3(-0.85, 1.55, -3.05), Vector3(1.35, 0.82, 0.12), Color(0.015, 0.035, 0.06), true)
    _add_box(Vector3(0.85, 1.55, -3.05), Vector3(1.35, 0.82, 0.12), Color(0.015, 0.035, 0.06), true)
    _add_box(Vector3(0, 0.91, -2.45), Vector3(1.35, 0.035, 0.42), Color(0.08, 0.14, 0.19))

    # Server room racks along the right wall.
    for rack_index in range(3):
        var rack_x := 5.2 + float(rack_index) * 1.65
        _add_box(Vector3(rack_x, 1.45, -6.0), Vector3(1.15, 2.9, 0.9), Color(0.018, 0.035, 0.06))
        _add_box(Vector3(rack_x, 2.95, -5.52), Vector3(1.0, 0.06, 0.04), THEME_COLORS[theme_index], true)
        for shelf_index in range(4):
            var shelf_y := 0.55 + float(shelf_index) * 0.62
            _add_box(Vector3(rack_x, shelf_y, -5.50), Vector3(0.88, 0.34, 0.08), Color(0.035, 0.09, 0.13))
            _add_box(Vector3(rack_x - 0.25, shelf_y, -5.44), Vector3(0.08, 0.08, 0.035), THEME_COLORS[theme_index], true)

    # AI research pod and equipment storage.
    _add_box(Vector3(-6.0, 1.1, -5.8), Vector3(2.2, 2.2, 1.4), Color(0.025, 0.07, 0.1))
    _add_box(Vector3(-6.0, 2.28, -5.05), Vector3(1.5, 0.08, 0.04), THEME_COLORS[theme_index], true)
    _add_box(Vector3(-6.0, 0.55, 2.0), Vector3(2.0, 1.1, 1.1), Color(0.035, 0.07, 0.11))
    _add_box(Vector3(-6.0, 1.2, 1.42), Vector3(1.7, 0.05, 0.04), THEME_COLORS[theme_index], true)

    _add_station_label("MAIN WORKSTATION", Vector3(0, 2.35, -3.0))
    _add_station_label("SERVER ROOM", Vector3(6.8, 3.2, -5.4))
    _add_station_label("AI RESEARCH", Vector3(-6.0, 2.65, -5.0))
    _add_station_label("EQUIPMENT STORAGE", Vector3(-6.0, 1.95, 1.4))

func _add_station_label(caption: String, at: Vector3) -> void:
    var label := Label3D.new()
    label.text = caption
    label.position = at
    label.font_size = 32
    label.modulate = Color(0.55, 0.9, 1.0)
    add_child(label)

func _add_box(pos: Vector3, box_size: Vector3, color: Color, themeable: bool = false) -> MeshInstance3D:
    var mesh_instance := MeshInstance3D.new()
    var mesh := BoxMesh.new()
    mesh.size = box_size
    mesh_instance.mesh = mesh
    mesh_instance.position = pos
    var material := StandardMaterial3D.new()
    material.albedo_color = color
    material.metallic = 0.65
    material.roughness = 0.35
    if themeable:
        material.emission_enabled = true
        material.emission = color
        mesh_instance.add_to_group("lab_theme")
    mesh_instance.material_override = material
    add_child(mesh_instance)
    return mesh_instance

func _build_hud() -> void:
    var hud: Control = $UI/HUD
    hud.mouse_filter = Control.MOUSE_FILTER_IGNORE

    var title := Label.new()
    title.text = "HACKER PROTOCOL: CYBER WORLD  //  LAB v0.3.0"
    title.position = Vector2(24, 18)
    title.add_theme_color_override("font_color", Color(0.25, 0.9, 1.0))
    hud.add_child(title)

    var help := Label.new()
    help.text = "WASD MOVE  |  SHIFT SPRINT  |  SPACE JUMP  |  E INTERACT  |  PAGE UP CAMERA"
    help.position = Vector2(24, 48)
    hud.add_child(help)

    objective_label = Label.new()
    objective_label.text = "OBJECTIVE: Explore the expanded HQ and activate the main workstation."
    objective_label.position = Vector2(24, 78)
    objective_label.add_theme_color_override("font_color", Color(0.8, 0.9, 1.0))
    hud.add_child(objective_label)

    status_label = Label.new()
    status_label.text = "LAB LEVEL 1  |  THEME: CYAN"
    status_label.position = Vector2(24, 108)
    status_label.add_theme_color_override("font_color", Color(0.35, 0.95, 0.75))
    hud.add_child(status_label)

    _build_lab_menu(hud)
    _build_mobile_controls(hud)

func _build_lab_menu(hud: Control) -> void:
    var menu := VBoxContainer.new()
    menu.set_anchors_preset(Control.PRESET_TOP_RIGHT)
    menu.position = Vector2(-190, 22)
    menu.size = Vector2(166, 190)
    menu.add_child(_make_menu_button("CHANGE THEME", _cycle_theme))
    menu.add_child(_make_menu_button("UPGRADE LAB", _upgrade_lab))
    menu.add_child(_make_menu_button("SAVE PROGRESS", _save_progress))
    menu.add_child(_make_menu_button("LOAD PROGRESS", _load_progress))
    hud.add_child(menu)

func _make_menu_button(caption: String, callback: Callable) -> Button:
    var button := Button.new()
    button.text = caption
    button.custom_minimum_size = Vector2(160, 38)
    button.focus_mode = Control.FOCUS_NONE
    button.pressed.connect(callback)
    return button

func _build_mobile_controls(hud: Control) -> void:
    var joystick := Control.new()
    joystick.name = "MobileJoystick"
    joystick.set_script(load("res://scripts/mobile_joystick.gd"))
    joystick.set_anchors_preset(Control.PRESET_BOTTOM_LEFT)
    joystick.position = Vector2(28, -198)
    joystick.size = Vector2(170, 170)
    hud.add_child(joystick)

    _add_action_button(hud, "JUMP", "jump", Vector2(-118, -205), Vector2(92, 62))
    _add_action_button(hud, "SPRINT", "sprint", Vector2(-225, -126), Vector2(92, 56))
    _add_action_button(hud, "USE", "interact", Vector2(-118, -126), Vector2(92, 56))
    var camera_button := _make_menu_button("CAMERA", _toggle_camera)
    camera_button.set_anchors_preset(Control.PRESET_BOTTOM_RIGHT)
    camera_button.position = Vector2(-335, -126)
    camera_button.size = Vector2(92, 56)
    camera_button.custom_minimum_size = Vector2(92, 56)
    hud.add_child(camera_button)

func _add_action_button(hud: Control, caption: String, action: String, offset: Vector2, button_size: Vector2) -> void:
    var button := Button.new()
    button.text = caption
    button.focus_mode = Control.FOCUS_NONE
    button.custom_minimum_size = button_size
    button.size = button_size
    button.set_anchors_preset(Control.PRESET_BOTTOM_RIGHT)
    button.position = offset
    button.add_theme_color_override("font_color", Color(0.8, 0.98, 1.0))
    button.add_theme_color_override("font_hover_color", Color.WHITE)
    button.add_theme_stylebox_override("normal", _mobile_button_style(Color(0.02, 0.16, 0.24, 0.88)))
    button.add_theme_stylebox_override("pressed", _mobile_button_style(Color(0.0, 0.48, 0.62, 0.95)))
    button.button_down.connect(func(): Input.action_press(action))
    button.button_up.connect(func(): Input.action_release(action))
    hud.add_child(button)

func _mobile_button_style(fill: Color) -> StyleBoxFlat:
    var style := StyleBoxFlat.new()
    style.bg_color = fill
    style.border_color = Color(0.1, 0.78, 1.0, 0.9)
    style.set_border_width_all(2)
    style.set_corner_radius_all(12)
    style.content_margin_left = 8
    style.content_margin_right = 8
    return style

func _cycle_theme() -> void:
    theme_index = (theme_index + 1) % THEME_COLORS.size()
    _apply_lab_theme()
    _update_status("Theme changed")
    _save_progress()

func _apply_lab_theme() -> void:
    var accent := THEME_COLORS[theme_index]
    for item in get_tree().get_nodes_in_group("lab_theme"):
        if item is MeshInstance3D:
            var material := item.material_override as StandardMaterial3D
            if material:
                material.albedo_color = accent
                material.emission = accent

func _upgrade_lab() -> void:
    if upgrade_level >= 5:
        _update_status("Maximum lab level reached")
        return
    upgrade_level += 1
    var accent := THEME_COLORS[theme_index]
    _add_box(Vector3(5.2 + float(upgrade_level - 2) * 1.65, 3.15, -5.42), Vector3(0.8, 0.08, 0.05), accent, true)
    _update_status("Lab upgraded")
    _save_progress()

func _save_progress() -> void:
    var config := ConfigFile.new()
    config.set_value("lab", "theme_index", theme_index)
    config.set_value("lab", "upgrade_level", upgrade_level)
    var error := config.save(SAVE_PATH)
    if error == OK:
        _update_status("Progress saved on this device")
    else:
        _update_status("Save failed: " + str(error))

func _load_progress() -> void:
    var config := ConfigFile.new()
    var error := config.load(SAVE_PATH)
    if error != OK:
        _apply_lab_theme()
        _update_status("New lab profile")
        return
    theme_index = clampi(int(config.get_value("lab", "theme_index", 0)), 0, THEME_COLORS.size() - 1)
    upgrade_level = clampi(int(config.get_value("lab", "upgrade_level", 1)), 1, 5)
    _apply_lab_theme()
    _update_status("Progress loaded")

func _update_status(message: String) -> void:
    if is_instance_valid(status_label):
        var theme_names := ["CYAN", "VIOLET", "EMERALD"]
        status_label.text = "LAB LEVEL %d  |  THEME: %s  |  %s" % [upgrade_level, theme_names[theme_index], message]
    if is_instance_valid(objective_label):
        objective_label.text = "OBJECTIVE: Customize your HQ, upgrade equipment and save your progress."

func _toggle_camera() -> void:
    var player := get_tree().get_first_node_in_group("player")
    if player and player.has_method("toggle_camera"):
        player.toggle_camera()
