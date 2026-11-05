extends Control

var is_dragging := false
var value := Vector2.ZERO
var knob_radius := 25.0

func _ready() -> void:
    add_to_group("mobile_joystick")
    custom_minimum_size = Vector2(170, 170)
    mouse_filter = Control.MOUSE_FILTER_STOP
    queue_redraw()

func get_value() -> Vector2:
    return value

func _gui_input(event: InputEvent) -> void:
    if event is InputEventScreenTouch:
        is_dragging = event.pressed
        if is_dragging:
            _update_value(event.position)
        else:
            value = Vector2.ZERO
            queue_redraw()
    elif event is InputEventScreenDrag and is_dragging:
        _update_value(event.position)
    elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
        is_dragging = event.pressed
        if not is_dragging:
            value = Vector2.ZERO
            queue_redraw()
    elif event is InputEventMouseMotion and is_dragging:
        _update_value(event.position)

func _update_value(screen_position: Vector2) -> void:
    var local_position := screen_position - global_position
    var center := size * 0.5
    var offset := local_position - center
    var max_distance := min(size.x, size.y) * 0.36
    value = (offset / max_distance).limit_length(1.0)
    queue_redraw()

func _draw() -> void:
    var center := size * 0.5
    draw_circle(center, min(size.x, size.y) * 0.46, Color(0.02, 0.08, 0.14, 0.68))
    draw_arc(center, min(size.x, size.y) * 0.46, 0.0, TAU, 48, Color(0.15, 0.8, 1.0, 0.85), 3.0)
    draw_circle(center + value * (min(size.x, size.y) * 0.32), knob_radius, Color(0.1, 0.75, 1.0, 0.9))
