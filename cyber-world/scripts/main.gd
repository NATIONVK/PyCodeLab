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
