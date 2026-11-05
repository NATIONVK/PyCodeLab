extends Node

func open_terminal() -> void:
    var root := get_tree().current_scene
    var layer := root.get_node_or_null("UI")
    if layer == null:
        return
    var panel := layer.get_node_or_null("HackingPanel")
    if panel:
        panel.queue_free()
        return
    panel = PanelContainer.new()
    panel.name = "HackingPanel"
    panel.set_anchors_preset(Control.PRESET_CENTER)
    panel.position = Vector2(-230, -125)
    panel.size = Vector2(460, 250)
    var box := VBoxContainer.new()
    panel.add_child(box)
    var title := Label.new()
    title.text = "NOVA TERMINAL // TRAINING SIMULATION"
    title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    box.add_child(title)
    var prompt := Label.new()
    prompt.text = "Connect the virtual nodes in the correct order.\nThis is a fictional in-game puzzle."
    prompt.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    box.add_child(prompt)
    var answer := LineEdit.new()
    answer.placeholder_text = "Enter sequence: 1-2-3-4"
    box.add_child(answer)
    var feedback := Label.new()
    box.add_child(feedback)
    var submit := Button.new()
    submit.text = "RUN SIMULATION"
    submit.pressed.connect(func():
        if answer.text.strip_edges() == "1-2-3-4":
            feedback.text = "ACCESS GRANTED — MISSION REWARD UNLOCKED"
            var root := get_tree().current_scene
            if root and root.has_method("_on_simulation_completed"):
                root._on_simulation_completed()
        else:
            feedback.text = "SIMULATION FAILED — TRY AGAIN"
    )
    box.add_child(submit)
    var close := Button.new()
    close.text = "CLOSE"
    close.pressed.connect(func(): panel.queue_free())
    box.add_child(close)
    layer.add_child(panel)
