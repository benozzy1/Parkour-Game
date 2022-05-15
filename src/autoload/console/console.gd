extends Control

@export var label_path: NodePath
@onready var label: RichTextLabel = get_node(label_path)

@export var line_edit_container_path: NodePath
@onready var line_edit_container = get_node(line_edit_container_path)

@export var line_edit_path: NodePath
@onready var line_edit: LineEdit = get_node(line_edit_path)

var toggled: bool = false: set = set_toggled


func _ready() -> void:
	hide()
	
	visibility_changed.connect(_on_visibility_changed)
	
	#await _play_startup_animation()
#
	clear()
	write_line("Welcome to Parkour v0.1")
	write_line("Type 'help' for a list of commands")
	line_edit_container.get_node("Label").show()
	
	#timer.queue_free()
	
	CommandManager.command_executed.connect(_on_command_executed)


func _process(delta: float) -> void:
	var content_position: Vector2 = label.position + Vector2(0, label.get_content_height() - 4)
	if content_position.y < label.size.y:
		line_edit_container.position = content_position
	else:
		line_edit_container.position.y = label.position.y + label.size.y


func write(value: String) -> void:
	label.text += value


func write_line(value: String) -> void:
	label.text += value + "\n"


func clear() -> void:
	label.text = ""


func _play_startup_animation() -> void:
	var timer: Timer = Timer.new()
	add_child(timer)

	write_line("Starting parkour v0.1")
	timer.start(1.5)
	await timer.timeout

	write_line("")
	await _start_services()

	timer.start(2.0)
	await timer.timeout

	write_line("")
	write_line("GAME READY")

	timer.start(0.05)
	await timer.timeout

	clear()

	timer.start(3.0)
	await timer.timeout


func _start_services() -> void:
	await _start_service("Game")
	await get_tree().create_timer(0.25).timeout
	await _start_service("Audio")
	await get_tree().create_timer(0.125).timeout
	await _start_service("Network")


func _start_service(service_name: String) -> void:
	write_line("[[color=dark_gray]INFO[/color]] Starting service: %s" % [service_name])
	
	var duration: float = randf_range(0.05, 0.25)
	await get_tree().create_timer(duration).timeout
	
	write_line("[[color=green]OK[/color]] Service %s successfully started" % [service_name])


func _on_command_executed(name: String, args: Array = []) -> void:
	if not CommandManager.has_command(name):
		Console.write_line("[[color=red]ERROR[/color]] Command not found")


func _on_visibility_changed() -> void:
	if visible:
		line_edit.grab_focus()


func open() -> void:
	if not toggled:
		toggled = true
	
	var tween: Tween = create_tween()
	
	var duration: float = 0.25
	var trans = Tween.TRANS_EXPO
	var ease = Tween.EASE_OUT
	
	tween.parallel().tween_property(
		self,
		"modulate:a",
		1.0,
		duration
	).set_ease(ease).set_trans(trans)
	tween.parallel().tween_method(
		set_shader_param.bind("warp_amount"),
		0.0,
		1.0,
		duration
	).set_ease(ease).set_trans(trans)
	tween.parallel().tween_method(
		set_shader_param.bind("scanlines_opacity"),
		0.0,
		0.125,
		duration
	).set_ease(ease).set_trans(trans)
	tween.parallel().tween_method(
		set_shader_param.bind("grille_opacity"),
		0.0,
		0.3,
		duration
	).set_ease(ease).set_trans(trans)
	tween.parallel().tween_method(
		set_shader_param.bind("vignette_opacity"),
		0.0,
		0.5,
		duration
	).set_ease(ease).set_trans(trans)
	tween.parallel().tween_method(
		set_shader_param.bind("noise_opacity"),
		0.0,
		0.4,
		duration
	).set_ease(ease).set_trans(trans)
	tween.parallel().tween_method(
		set_shader_param.bind("abberation"),
		0.0,
		0.03,
		duration
	).set_ease(ease).set_trans(trans)
	tween.parallel().tween_method(
		set_shader_param.bind("brightness"),
		0.0,
		1.0,
		duration
	).set_ease(ease).set_trans(trans)
	set_shader_param(true, "discolor")
	
	await get_tree().create_timer(0.05).timeout
	line_edit.editable = true


func close() -> void:
	if toggled:
		toggled = false
	
	line_edit.editable = false
	
	var tween: Tween = create_tween()
	
	var duration: float = 0.25
	var trans = Tween.TRANS_EXPO
	var ease = Tween.EASE_OUT
	
	if tween == null:
		return
	
	tween.parallel().tween_property(
		self,
		"modulate:a",
		0.0,
		duration
	).set_ease(ease).set_trans(trans)
	tween.parallel().tween_method(
		set_shader_param.bind("warp_amount"),
		1.0,
		0.0,
		duration
	).set_ease(ease).set_trans(trans)
	tween.parallel().tween_method(
		set_shader_param.bind("scanlines_opacity"),
		0.125,
		0.0,
		duration
	).set_ease(ease).set_trans(trans)
	tween.parallel().tween_method(
		set_shader_param.bind("grille_opacity"),
		0.3,
		0.0,
		duration
	).set_ease(ease).set_trans(trans)
	tween.parallel().tween_method(
		set_shader_param.bind("vignette_opacity"),
		0.5,
		0.0,
		duration
	).set_ease(ease).set_trans(trans)
	tween.parallel().tween_method(
		set_shader_param.bind("noise_opacity"),
		0.4,
		0.0,
		duration
	).set_ease(ease).set_trans(trans)
	tween.parallel().tween_method(
		set_shader_param.bind("abberation"),
		0.03,
		0.0,
		duration
	).set_ease(ease).set_trans(trans)
	tween.parallel().tween_method(
		set_shader_param.bind("brightness"),
		1.4,
		1.0,
		duration
	).set_ease(ease).set_trans(trans)
	set_shader_param(false, "discolor")


func set_shader_param(value: Variant, param: StringName) -> void:
	$CRTEffect.material.set_shader_param(param, value)


func toggle() -> void:
	toggled = !toggled


func set_toggled(value: bool) -> void:
	toggled = value
	
	if toggled:
		open()
	else:
		close()
