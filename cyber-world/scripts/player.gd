extends CharacterBody3D

@export var walk_speed := 4.5
@export var sprint_speed := 7.0
@export var jump_velocity := 4.5
@export var mouse_sensitivity := 0.0025
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var first_person := false
var camera_pitch := 0.0
@onready var pivot: Node3D = $CameraPivot
@onready var body_mesh: MeshInstance3D = $BodyMesh

func _ready() -> void:
    add_to_group("player")
    Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
        _rotate_camera(event.relative)
    if event is InputEventScreenDrag:
        var viewport_size := get_viewport().get_visible_rect().size
        if event.position.x > viewport_size.x * 0.38 and event.position.y < viewport_size.y * 0.78:
            _rotate_camera(event.relative)
    if event.is_action_pressed("ui_cancel"):
        Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
    if event is InputEventMouseButton and event.pressed:
        Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
    if event.is_action_pressed("ui_page_up"):
        toggle_camera()

func _rotate_camera(relative_motion: Vector2) -> void:
    rotate_y(-relative_motion.x * mouse_sensitivity)
    camera_pitch = clamp(camera_pitch - relative_motion.y * mouse_sensitivity, -1.15, 1.15)
    pivot.rotation.x = camera_pitch

func toggle_camera() -> void:
    first_person = not first_person
    pivot.position.y = 1.55 if first_person else 1.45
    pivot.get_node("SpringArm3D").spring_length = 0.0 if first_person else 4.0
    body_mesh.visible = not first_person

func _physics_process(delta: float) -> void:
    if not is_on_floor():
        velocity.y -= gravity * delta
    if Input.is_action_just_pressed("jump") and is_on_floor():
        velocity.y = jump_velocity

    var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
    var joystick := get_tree().get_first_node_in_group("mobile_joystick")
    if joystick and joystick.has_method("get_value"):
        var touch_input: Vector2 = joystick.get_value()
        if touch_input.length() > 0.08:
            input_dir = touch_input
    var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
    var speed := sprint_speed if Input.is_action_pressed("sprint") or Input.is_key_pressed(KEY_SHIFT) else walk_speed
    if direction:
        velocity.x = direction.x * speed
        velocity.z = direction.z * speed
    else:
        velocity.x = move_toward(velocity.x, 0, walk_speed)
        velocity.z = move_toward(velocity.z, 0, walk_speed)
    move_and_slide()

    if Input.is_action_just_pressed("interact"):
        _try_interact()

func _try_interact() -> void:
    var space := get_world_3d().direct_space_state
    var from := global_position + Vector3.UP
    var to := from + -global_transform.basis.z * 3.0
    var query := PhysicsRayQueryParameters3D.create(from, to)
    query.exclude = [self]
    var hit := space.intersect_ray(query)
    if hit and hit.collider:
        var collider_node: Node = hit.collider as Node
        if collider_node.has_meta("station_id"):
            var root := get_tree().current_scene
            if root and root.has_method("_on_station_interacted"):
                root._on_station_interacted(str(collider_node.get_meta("station_id")))
            return
        var terminal: Node = collider_node.get_node_or_null("TerminalLogic")
        if terminal:
            terminal.open_terminal()
