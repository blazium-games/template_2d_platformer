extends Node2D

const Rules = preload("res://scripts/rules.gd")
var rules = Rules.new()

@onready var runner: CharacterBody2D = $Runner
@onready var hazard: Area2D = $HazardStrip
@onready var goal: Area2D = $GoalStrip

func _ready() -> void:
	$SheetLens.make_current()
	hazard.body_entered.connect(_hazard_in)
	hazard.body_exited.connect(_hazard_out)
	goal.body_entered.connect(_goal_in)

func _hazard_in(hit: Node2D) -> void:
	if hit == runner:
		rules.mark_hazard()

func _hazard_out(hit: Node2D) -> void:
	if hit == runner:
		rules.clear_hazard()

func _goal_in(hit: Node2D) -> void:
	if hit == runner and rules.try_goal() and rules.may_span():
		_go("res://scenes/span.tscn")

var air_time := 0.0

func _physics_process(delta: float) -> void:
	var axis := Input.get_action_strength("stride_east") - Input.get_action_strength("stride_west")
	runner.velocity.x = axis * 180.0
	if runner.is_on_floor():
		air_time = 0.0
		rules.coyote_used = false
	else:
		air_time += delta
	if Input.is_action_just_pressed("leap") and (runner.is_on_floor() or rules.coyote_hop(air_time)):
		runner.velocity.y = -280.0
	runner.velocity.y += 800.0 * delta
	runner.move_and_slide()

func _go(next_path: String) -> void:
	get_tree().change_scene_to_file(next_path)
