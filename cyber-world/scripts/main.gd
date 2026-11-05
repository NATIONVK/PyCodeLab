extends Node3D

func _ready() -> void:
    _build_lab()
    _build_hud()

func _build_lab() -> void:
    # Modular placeholder props for the first playable lab blockout.
    _add_box(Vector3(-4, 1.0, -4), Vector3(1.2, 2.0, 1.2), Color(0.04, 0.12, 0.2))
    _add_box(Vector3(4, 1.0, -4), Vector3(1.2, 2.0, 1.2), Color(0.04, 0.12, 0.2))
    _add_box(Vector3(-4, 1.0, 4), Vector3(1.2, 2.0, 1.2), Color(0.04, 0.12, 0.2))
    _add_box(Vector3(4, 1.0, 4), Vector3(1.2, 2.0, 1.2), Color(0.04, 0.12, 0.2))
    _add_box(Vector3(0, 2.5, -11.5), Vector3(24, 5, 0.4), Color(0.025, 0.04, 0.09))

func _add_box(pos: Vector3, size: Vector3, color: Color) -> void:
    var mesh_instance := MeshInstance3D.new()
    var mesh := BoxMesh.new()
    mesh.size = size
    mesh_instance.mesh = mesh
    mesh_instance.position = pos
    var material := StandardMaterial3D.new()
    material.albedo_color = color
    material.metallic = 0.65
    material.roughness = 0.35
    mesh_instance.material_override = material
    add_child(mesh_instance)

func _build_hud() -> void:
    var hud := $UI/HUD
    var title := Label.new()
    title.text = "HACKER PROTOCOL: CYBER WORLD     //     NATIONVK"
    title.position = Vector2(24, 18)
    title.add_theme_color_override("font_color", Color(0.25, 0.9, 1.0))
    hud.add_child(title)
    var help := Label.new()
    help.text = "WASD: MOVE   SHIFT: SPRINT   SPACE: JUMP   E: INTERACT   PAGE UP: CAMERA   MOUSE: LOOK"
    help.position = Vector2(24, 48)
    hud.add_child(help)
    var objective := Label.new()
    objective.text = "OBJECTIVE: Explore your first Hacker Lab and activate the workstation."
    objective.position = Vector2(24, 78)
    objective.add_theme_color_override("font_color", Color(0.8, 0.9, 1.0))
    hud.add_child(objective)

    _build_mobile_controls(hud)

func _build_mobile_controls(hud: Control) -> void:
    var joystick := Control.new()
    joystick.name = "MobileJoystick"
    joystick.set_script(load("res://scripts/mobile_joystick.gd"))
    joystick.set_anchors_preset(Control.PRESET_BOTTOM_LEFT)
    joystick.position = Vector2(28, -198)
    joystick.size = Vector2(170, 170)
    hud.add_child(joystick)

    _add_action_button(hud, "JUMP", "jump", Vector2(-118, -205), Vector2(92, 62), true)
    _add_action_button(hud, "SPRINT", "sprint", Vector2(-225, -126), Vector2(92, 56), false)
    _add_action_button(hud, "USE", "interact", Vector2(-118, -126), Vector2(92, 56), true)

func _add_action_button(hud: Control, caption: String, action: String, offset: Vector2, button_size: Vector2, one_shot: bool) -> void:
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
    if one_shot:
        button.button_down.connect(func(): Input.action_press(action))
        button.button_up.connect(func(): Input.action_release(action))
    else:
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
